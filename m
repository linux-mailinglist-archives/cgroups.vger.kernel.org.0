Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7445D553
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2019 19:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfGBRd3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Jul 2019 13:33:29 -0400
Received: from mout.web.de ([217.72.192.78]:53473 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBRd3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 2 Jul 2019 13:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562088791;
        bh=lVjT2ewFqk1ytdCtHu/OnHNzgzrQYPG56Na/OyfRN9o=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=q+uICQZuVbm+qQliAF3uODVywi7KkRRU9KBxXxXUSQxMyPwTPBiW3F4AHU31/mnM4
         CLQkYfJ/6baG0NINIA4FVk0dCmP5o16egB79auUF/Fzz0H+ns2hKCc+lTbOJdKPLg6
         jQ5mvA7sQsoYJWboDwcmfVBh9QLOrrlXQ60w1fqY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHGG-1hdwne3vDU-004Q4N; Tue, 02
 Jul 2019 19:33:11 +0200
To:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cgroup: Replace a seq_printf() call by seq_puts() in
 cgroup_print_ss_mask()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d465ca81-a870-b88c-0ea2-5e8bfbefb79d@web.de>
Date:   Tue, 2 Jul 2019 19:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gJQ5usvvsq65dzFd7IoGwAqCx0vhE24I0AfbP1vKexyeze6Z8+d
 WcwEi07Y2/Op1Z0xL+DNv2feF1/H8N5qyNeH7UvKvU9ARv3c+qtHGWydFHGYC4k36vPUy6x
 cWb2C4LPaVxgBt8dOCUa3Q5rJWK2DxQupM7WmoKx7cj/PvCUO0+ZGwedTBbCv9s9pHM8pWs
 t1H4sVgxOV4G4agfXanOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VLd09dWw0KU=:ddbL9FcjRdFzFQRgwmD7OI
 Ipz4qmCixeeng5lGgcqrIH9MksBafFGw0Oyo4t0cDh6kF8d1RGra0RodSUDBlzjwIRfgbCmOF
 wcYXq72PocHA45Ebede2yYdugArw2Tmvh8vw1MKO7y5qy3P+shug3DI9SODNXYv5JBJsVG+DY
 SR2CP4v3mos6zYzdZfbCswpQ8C1PNGqBRAxhMbK4RZ6tvAHY/Qp5q6rdxebl1kALsLWfUANdB
 8fFJqeYYFo555c4daYGjAtmRWtx+NKlUbxNyfp2cIq2Z4+OBiCCs+OyTK4apEbIUJSPbnh3Bh
 jxvjchu1T6ynGLM0ThnTFBaLj+HAz0d/ViBYNOeEsrP7Zlpkn4vv2u0BHUc144tjG+oN4POO6
 bNLkbXyoLOD5dHo9YXne6275MDRCC5SnKh4Kl9eQQB/zCkWXj+cBGhfyj14m//FEZTT8r6GH0
 TAkATT0pbENamf2f5IIkgDDrKR5yZvUcWvFsbirBI16JD5MMOKgo4gcDrGD8uF+eZJNKonHt/
 6AyqZOmvwShlFiP68WEGrwEU2wFYSdmiuMRdDJrO4jAVpb0IERQWAHjJ3Y4uqGGLAwojtjx9I
 +mjv0rOSHG0WEGxzvzhJOtdbAStTzp83xVrg02aNcU8XtJ0BtI2AVjBAE+E153uRugTU9gJmL
 QPHeeEHqKSH9RT7ZepYSj8RDgx+omsjdetasglWliZXgX/kYwV5zYWFqArWxqjvYMgGKzTDt+
 oDP9onWHr7HIjCfBEgSzkpUiBK9T9AOkmrLNnIwBeyIYCMT9J3yHOyDSYFQixR930S+jK+H87
 8IbQVvtSyqT1rVkDiOb4hwnDkIedy748OoWa0hW6w87sFM4ePDo9/rGnWelTBQBzzou522N74
 VTOTWzYobE8qfoqyC3DqjKG/tNU0uoyQ7ATnCCfX1Lqeh7U0Oors/k1Zn56So7kK8NpnPWMMz
 +GJA/NRs6+PwiRpeLwMQypw5wWuVO2XiOt6Ncl2toIPWW/Y+MnDimeCI51yoqpzsRrfQ7PG4W
 Q+bL8wsovy0PkFHpFdajtG5yFMuXSMS8prTUuB4cF6ZCpP6z0nxcPgMDR9iXInx3skDlonulC
 +a1/2ZNjPfMHnDH6uxFn/xKEpHWv0AT/Ygo
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 19:26:59 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 300b0c416341..9d04e3004e3b 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2851,7 +2851,7 @@ static void cgroup_print_ss_mask(struct seq_file *se=
q, u16 ss_mask)
 	do_each_subsys_mask(ss, ssid, ss_mask) {
 		if (printed)
 			seq_putc(seq, ' ');
-		seq_printf(seq, "%s", ss->name);
+		seq_puts(seq, ss->name);
 		printed =3D true;
 	} while_each_subsys_mask();
 	if (printed)
=2D-
2.22.0

