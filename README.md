# rsync-deploy
Repositorio para implementar deploys mediante rsync

## Ejemplo de uso:

```yaml
      - name: rsync web files
        uses: secco-ar/rsync-deploy@main
        with:
          switches: -avzr
          remote_path: ${{ secrets.LINUXQAS1_APACHE_WEBROOT }}/<destino>
          remote_host: ${{ secrets.LINUXQAS1_IP_PUBLICO }}
          remote_port: ${{ secrets.LINUXQAS1_PUERTO_PUBLICO }}
          remote_key: ${{ secrets.LINUXQAS1_PRIVATEKEY_ROOT }}
```

Por defecto el owner es apache. De requerir otro usuario:grupo es necesario pasarlo como parámetro:

```yaml
      - name: rsync web files
        uses: secco-ar/rsync-deploy@main
        with:
          switches: -avzr
          owner: root
          remote_path: ${{ secrets.LINUXQAS1_APACHE_WEBROOT }}/<destino>
          remote_host: ${{ secrets.LINUXQAS1_IP_PUBLICO }}
          remote_port: ${{ secrets.LINUXQAS1_PUERTO_PUBLICO }}
          remote_key: ${{ secrets.LINUXQAS1_PRIVATEKEY_ROOT }}
```
