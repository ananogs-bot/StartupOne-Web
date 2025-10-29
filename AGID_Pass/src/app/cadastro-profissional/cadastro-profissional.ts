import { Component, OnInit } from '@angular/core';
import { NgForm } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Profissional } from '../services/models/models';
import { ProfissionalService, Categoria } from '../services/api/profissional.service';
import { RouterLink } from '@angular/router';

@Component({
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  selector: 'app-cadastro-profissional',
  templateUrl: './cadastro-profissional.html',
  styleUrls: ['./cadastro-profissional.css']
})
export class CadastroProfissional implements OnInit {

  nome = '';
  email = '';
  senha = '';
  telefone = '';
  cnpj = '';
  endereco = '';
  descricao = '';
  imagem = '';

  categorias: Categoria[] = [];
  categoriasSelecionadas: number[] = [];

  toggleCategoria(categoriaId: number, event: any) {
    if (event.target.checked) {
      this.categoriasSelecionadas.push(categoriaId);
    } else {
      this.categoriasSelecionadas = this.categoriasSelecionadas.filter(id => id !== categoriaId);
    }
  }

  ngOnInit(): void {
    this.carregarCategorias();
  }

  carregarCategorias() {
    this.profissionalService.getCategorias().subscribe({
      next: (data) => this.categorias = data,
      error: (err) => console.error('Erro ao carregar categorias', err)
    });
  }

  constructor(private profissionalService: ProfissionalService) { }

  cadastrarProfissional(form: NgForm) {
    const body: Profissional & { categorias: number[] } = {
      profissional_nome: this.nome,
      profissional_email: this.email,
      profissional_senha: this.senha,
      profissional_telefone: this.telefone,
      profissional_cnpj: this.cnpj,
      profissional_endereco: this.endereco,
      profissional_descricao: this.descricao,
      profissional_imagem: this.imagem,
      categorias: this.categoriasSelecionadas
    };


    this.profissionalService.cadastrarProfissional(body).subscribe({
      next: res => {
        console.log('Profissional cadastrado', res);
      },
      error: err => console.error(err)
    });
  }
}
