import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CadastroProfissional } from './cadastro-profissional';

describe('CadastroProfissional', () => {
  let component: CadastroProfissional;
  let fixture: ComponentFixture<CadastroProfissional>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CadastroProfissional]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CadastroProfissional);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
