Return-Path: <cgroups+bounces-3670-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8B930977
	for <lists+cgroups@lfdr.de>; Sun, 14 Jul 2024 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD10281CA8
	for <lists+cgroups@lfdr.de>; Sun, 14 Jul 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4487E45038;
	Sun, 14 Jul 2024 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="w6wg8hOk"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BA3A8C0;
	Sun, 14 Jul 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720949621; cv=none; b=cngzxX/BttfcTeAqgUcxUS2gOMMQtluWd6GERDvds7K6ixKKAu0hQd26HDi0mhQlZaonnDz8TDahyywG9pSTlu8Atd8V85A/oUPsM6lCDYCpgDQ77cbNvjVujT6f0SBn9sgBncTDQaeq/C936NgBtzxgvpgaDz1IZQP3zpL/eWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720949621; c=relaxed/simple;
	bh=66W94Qlr5tmW71QHKaOmYeVfbqOJtCFE9dnGo5yItiU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FEl3VLt94026YMEqnC0mrv0sci4U/2Qr8hbe3otZK0+4G8GJy9cJvBt+vPT07tirMzJnk4K8p6uOvKUgQqOt1qLm8QVIm5wcCwGMox00XXYJ2s7J6rh9X7c2oH5sfO6wrKpG0F9Su4LQCUvVuK0ZjmWpC8N+Gq30VUzR48XNFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=w6wg8hOk; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720949599; x=1721554399; i=markus.elfring@web.de;
	bh=aLeqHr1jvfeI2WXDfAAOXkAuSH/H3gXk27n2+n8sw8I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=w6wg8hOk9zJu/8DkrfZbROy+CIx23ZbUJlGZNaaOkpem0aXZ87rknf7p0DSSEFW4
	 rKdpEtSYzKx8edp9j6lUHV3fShLfSZSuymtVtqVcJUvVh6h0QGjxEabAraVbLP/vP
	 UOJoebdB3dhtY2aJHxT2Q9eVrCuPrWgNsHbriFNIiDtG9nLzoYxs/h5olj6iFkAk2
	 d0WKWKWOUXQ42M2AqYcLV3TIy91uhFb4rNBPrQctzhxKuvo+g8rZ4M7OcGf1Asi1a
	 ZoEbR2QiS+M8NXJKmh33+1eHnQZa8R4Vfo2Nr7QSkmfZXP5uZvxMjMJImkD6pCE9q
	 sI2nOn4wIyTUDM29kA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpU1u-1s1J1X2y3Y-00nBP7; Sun, 14
 Jul 2024 11:33:19 +0200
Message-ID: <8ff2d1aa-4c48-4cb1-b5d5-675adb90ae81@web.de>
Date: Sun, 14 Jul 2024 11:33:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cgroup: Use seq_putc() in three functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SSUQHcCcuwZU/1J4YNud6Pf4kHGLlefSxecxEkkCY5lpVB9KFmq
 3Amb657a1pqI9kpzVknExXSPL0ALVxZhWtO6RHQUFo2DDn9I2lDQPiRI95KXeQis645DQtO
 l7axU9s9p5FKRnyOfNGylG0QL+PKJmLkYA8nZ3Ec59e8yvkG7edWdPivZZAcLd868ImK+QT
 zMdl4i7tEpaZugaWO1akg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LXgjEuqR0JE=;OPOlV7gXFyiLcWBhR4fjoI4CJRO
 CQHTUlH2NZca0iOvJjfoc10tLg1WRaaFIbMCq2HJ9zazGHi8NgeOIVAfgidmNDVXrHMHdmy5A
 YsOHlneGCPcNQhUNsV7QlPS0CFPjmJYNHvZpuCH55XRk9D5bgQI3pICPSFgEsypr8/EmnnmqM
 mEWDclMpIZxm4oHjRpslvDhNotMn9bp6gdsHfknfncqrSnhyxKPiMkaQyTFe7dCF70SoKmKzC
 SNwco9dri5Am88Ks8h9ATSLYjNJuO3mnZjQfj9Lpn2aOVlsyWWJ+gxOGGp7Q5sZCs3RViQRWk
 fr34oCiDVKZv7VZrlnotOtDWrtG1vAtqmb6OE60xyD8QFXZs0BWGuLzGn2GwW6IHM0SDqdKS3
 O1HwoZko7Np+P+0OGuh+LvsR96NTIzMwqxM/TK/M4L6wnaexK0oy5fHwSUoYd8pqBe+VDNEiP
 v30MQcZ5hcE8wYfX5eqnPXg240FL5WWkqXZokdD/gtZIwZw0vjbUPtTzQO52YQnWuOXh+qfgf
 1z4+UMVhVvZyLAsCwZh/80ZI19veOvmT/a4QyZ55XfNJqIyAMsJy0SbMHoyJLdoU8KErfBe2D
 RPeEqYpgMjeFpt2f+VYydrQy0aPUWhxUOsVpf1LuPxIkrs3fzHY6TKVzT2jAEVE3oF6jBNFJm
 mod/VueRtplTTeGvdINtYWFt8FjsmqhWgZLSDEwprEXoOP8gNZURK9o8FFDBZtYSW8msny2s4
 IT7rSJ38J2kSGMjh8eJNkgi1lc93tMfDtzMCpYR9mqMunCZFuUHi/YBCCRZd2e6miIs2AnIe1
 7PiDa7UJjcYrCUkY6fWTs05g==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 11:24:05 +0200

Single characters should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/cgroup/cgroup.c | 2 +-
 kernel/cgroup/debug.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index c8e4b62b436a..9197f3c591a9 100644
=2D-- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6316,7 +6316,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_=
namespace *ns,

 			seq_puts(m, buf);
 		} else {
-			seq_puts(m, "/");
+			seq_putc(m, '/');
 		}

 		if (cgroup_on_dfl(cgrp) && cgroup_is_dead(cgrp))
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..d18f7dcb4def 100644
=2D-- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -55,7 +55,7 @@ static int current_css_set_read(struct seq_file *seq, vo=
id *v)
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
 	if (refcnt > cset->nr_tasks)
 		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');

 	/*
 	 * Print the css'es stored in the current css_set.
@@ -159,7 +159,7 @@ static int cgroup_css_links_read(struct seq_file *seq,=
 void *v)
 				extra_refs +=3D extra;
 			}
 		}
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');

 		list_for_each_entry(task, &cset->tasks, cg_list) {
 			if (count++ <=3D MAX_TASKS_SHOWN_PER_CSS)
@@ -189,7 +189,7 @@ static int cgroup_css_links_read(struct seq_file *seq,=
 void *v)
 	if (!dead_cnt && !extra_refs && !threaded_csets)
 		return 0;

-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 	if (threaded_csets)
 		seq_printf(seq, "threaded css_sets =3D %d\n", threaded_csets);
 	if (extra_refs)
=2D-
2.45.2


