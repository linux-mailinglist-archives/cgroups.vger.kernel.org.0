Return-Path: <cgroups+bounces-1047-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E013B820A53
	for <lists+cgroups@lfdr.de>; Sun, 31 Dec 2023 08:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953842833C5
	for <lists+cgroups@lfdr.de>; Sun, 31 Dec 2023 07:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA73185D;
	Sun, 31 Dec 2023 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ELwpUcpY"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C55C17C2;
	Sun, 31 Dec 2023 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704007702; x=1704612502; i=markus.elfring@web.de;
	bh=PcBUvluZb/BvdgF7ktzLibEt8A6a4VGufG/N/XU2tBU=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ELwpUcpYPoNstTo91UNCbohC7BFOMxxWrqAkEmEOqjWz3nqiDvzL2I3euvfKyNmI
	 nPi3A5ivgBq/LZiGsIH+l6YnzuXg1opvuAi7X/4VvtW7ALscdj5B/jiaihEIzg0lz
	 VORijwlqpsLv+KQaO2212muYJ6Cg9HbiH2txaffdryuEpvzZ7xoU0z08mFzTcL4ox
	 fF8zl/KPXt/VQjrzzIs3E03Qxl3P27dx7FEcVQ7sRTvlHWN3wOEyREq5yBH0YydYI
	 fbAACO6kC25hBxQ7qjDYWo1MaXkovH0U3VBByJSjb0IKAGyhK9namzw9ZeDnWb9Va
	 LA0hLj24xtUhjcSbZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MkVwo-1qxSnY0oKE-00mBMi; Sun, 31
 Dec 2023 08:28:22 +0100
Message-ID: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
Date: Sun, 31 Dec 2023 08:28:08 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] cgroup/cpuset: Adjust exception handling in
 generate_sched_domains()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pgnSzo2W+vneiGpO38IiNDAlEaIXKSMMACiIapp8BWsnXekDcdT
 PbTKnujXFwSFjr6dNhr2LWeXpGIYfELudkL0U/datOqgwQAGOG/p9DwHtGBFh/9TQQafMBx
 pd+MTC5ua7UFSk/OLfcvENKiCpoFoOWzzkxvHQ+qqoVir1t+VcPONx+YOK5gSR+1EnqEaYv
 0Fq2o9AvO1SPmzhnL2LyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MF8NwxLMoUE=;Vth/hMGB+E6eKMV2W7MGJ4MxLZ9
 hf387lQW9S4mRbLHw+Wk1eXh7IbH+bgBJcy+74ziZppgtw0VnnxAe5jSfvj68WT4yCJJ/Nwvc
 BWJ8IKnFwUDWr2Kk70SQv2jfBC3WA6dZPSjPXCb+esuBBnLv4YTDuBhQigtyV+y0Za3A10B7A
 yxAq/Fk+Jmim1yWVSd5OBavzsMkvdSjw9V3xIz5/cVckRMsEIgheJT3wFUqxKTZNpG5t32mcD
 ggFRvYvU2FysZZp0bB6dShfetu8WG1oot+Kw62+/MVsh35d8/UKxNvZu1nmD1aQC5kPFwh19n
 TEmjEgHyRG2oPSMt5VXucXMoHBS6l+HuGcI1OUk917w28P1DWe5nXfCuhhrZHp5IFPvGXtaRe
 MPUjozzfWjDMuT5F7TKq4A/rICf6lRPeWfhSB1brZp8x72mfmQX3E4hmM0RN3SPku4Fro6kjt
 VPN8BRJJP+jg/+KqDgIYxt7OC1L9F9oHSMtJ9xALb9kv7ftI5A14kT/9u5E8m5RcZfBfUq7Ob
 4TrJM7zUO4dImuHeG7tmPDlDeKTrH2RhgBCia8zAlLdHTh9h59+MWSXsD6QP6Frl1ZkkRnhYc
 B76CGZ6ZHAyKp31HgPvYCYw6SOoXHzKc2BWKRGFXu1gaborbduJsWr02wcmKT7wnXORtwM/Ul
 dCRVeLp1kzUfsFUq4iC8Cj2ve5zwMG+zly/IfCUpF4q7Fdu2AxS/zJsC6Kvom89eGf8twuRb6
 4jdUSIsetjqDbx910SJ/COQuAeUSNqHW0w/6HO7YQMYmsjYE34UAxFrGOVbGAJUDrRP616MyE
 AgikrA491MEz8xjVuqhULxPJ/BrThtIt4OrEZz8nnv5YIrTf3j79DA+CKuryk/mx5MeXcEKeT
 7z35aZi/HPSiirS9mGKOQ4ychsjertrc23Jb4ZLEVaRdgUobNWgsbRFS3Fv8APXd+S5im2PiT
 uy8gWQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 08:00:31 +0100

Two resource allocation failures triggered further actions
over the label =E2=80=9Cdone=E2=80=9D so far.

* Jump to the statement =E2=80=9Cndoms =3D 1;=E2=80=9D in three cases dire=
ctly
  by using the label =E2=80=9Cset_ndoms=E2=80=9D instead.

* Delete an assignment for the variable =E2=80=9Cndoms=E2=80=9D in one if =
branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/cgroup/cpuset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ba36c073304a..29ccd52eb45c 100644
=2D-- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -973,10 +973,9 @@ static int generate_sched_domains(cpumask_var_t **dom=
ains,

 	/* Special case for the 99% of systems with one, full, sched domain */
 	if (root_load_balance && !top_cpuset.nr_subparts) {
-		ndoms =3D 1;
 		doms =3D alloc_sched_domains(ndoms);
 		if (!doms)
-			goto done;
+			goto set_ndoms;

 		dattr =3D kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
 		if (dattr) {
@@ -986,12 +985,12 @@ static int generate_sched_domains(cpumask_var_t **do=
mains,
 		cpumask_and(doms[0], top_cpuset.effective_cpus,
 			    housekeeping_cpumask(HK_TYPE_DOMAIN));

-		goto done;
+		goto set_ndoms;
 	}

 	csa =3D kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
 	if (!csa)
-		goto done;
+		goto set_ndoms;
 	csn =3D 0;

 	rcu_read_lock();
@@ -1123,6 +1122,7 @@ static int generate_sched_domains(cpumask_var_t **do=
mains,
 	 * See comments in partition_sched_domains().
 	 */
 	if (doms =3D=3D NULL)
+set_ndoms:
 		ndoms =3D 1;

 	*domains    =3D doms;
=2D-
2.43.0


