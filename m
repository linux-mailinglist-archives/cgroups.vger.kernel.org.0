Return-Path: <cgroups+bounces-1049-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25598821358
	for <lists+cgroups@lfdr.de>; Mon,  1 Jan 2024 09:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A68B21CD5
	for <lists+cgroups@lfdr.de>; Mon,  1 Jan 2024 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4260717C6;
	Mon,  1 Jan 2024 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="p6AgW3xS"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436E17C8;
	Mon,  1 Jan 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704099456; x=1704704256; i=markus.elfring@web.de;
	bh=agDsBCNizMRnAhd3ZLJbePedKBgljy4IQu9qS5vaM9U=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=p6AgW3xSKvzw/ZSqUEwWFeRwaqeoRrV9fPVTPvrf/Q9VWTXpin/fUJX/PRTb19mf
	 sBz/3HPobLINIBRSAWNWlomo638nrp/9XGW5L0dEimB5TvXp/+ve8Kb75U0Lf0wSO
	 +fX9iKA1r2IhrDUcexrjJZmUEeLQevbRtLduOfAvfL9s990qvqh/3pzwxqlp14cUN
	 p0zmltsRA1UcbA9srFfAMMLx4hdCoc07ahqRyVGTXKdToTz7J45Ybyqiqg6kkhzvC
	 iJmnOuCE0YCkt/8ciqNNgkCIrjMCPZ1uVmJDwNQOQUxKbzm4L27Os8pzCUZVzsrlI
	 BWH5gpNJ+uPfCO73Kg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MpU1w-1qsnjY1G28-00q14H; Mon, 01
 Jan 2024 09:57:36 +0100
Message-ID: <b441f304-a3cc-4ebe-91cb-84caf55cbfe2@web.de>
Date: Mon, 1 Jan 2024 09:56:53 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Adjust exception handling in
 generate_sched_domains()
To: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <53be5f98-6359-48b5-955e-fd203d99d3cb@web.de>
 <9cd1ce1d-15c7-427c-9929-f3c75b97b49c@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9cd1ce1d-15c7-427c-9929-f3c75b97b49c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Nt0ajD4ZaUbOXmcwE4wMyZy7kP2gGXaGyEGiaR/J5xah78nfeRQ
 rjDvyjN+Cx71OgiCR3gTw6RTTU2EiWdEECokCntHuVmDHuXmV2D7uO+7se93HAdGIF+7r/O
 +0VDt8Jgc/7XYG7NzEY7Buau01KX3JfpmcRIvJ6/ByG1WlpI0ON6TBPKtGMDikqXxQ7/dSS
 iH12QbJ81RWT2lUZGsBiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FtZC8cznO5E=;7FrmcAQ4cUKIffUX75YG7eV3iWQ
 WZY/5EGwBaJO3XpDUc6+uW8XeW6l8pAgb15FjXRgRdt1LUwrJQH49FObRb4xeGhEn84zDURxg
 4BBWALxKEmF7IbFc+KvdP9pGJNoChNH3TGh1tXD3OvWx0rwjBIevx0hC9LQqc3dHAL5EeRIbt
 esl98hUXon0HTu7EuZlK3ahwVFoSR5lQLy+54YdCiJu6RKoL/NDS9qrUH19iir11/5mNRbOyK
 nx+v8GjbtWBogBNr4Te3JLj1L9ArasTceSuCg77LUPcd9K2uylmLA+tnbiIuGJ68fbXD+xdls
 +3LurC2Vt6a1iZyZVI1Ai4ICbXTd/o29XSOQScTqzOZafttAfnVJjaLr3K9JLK0zfXsageedz
 kaXbvTICwxJRDT0XjUKO+CNpc8P1XZn1tm7zCi1hLGQZLbiRQmZxPwpvAD9/ZGGytZKeF8VxO
 Vx6MagNWO/2jdf4ovRXdpOZudsU4ErLAGmc+x3dHIdtrhrlpprAJGP0CHJM0g/iZGaeJOAMAI
 ekm7Vf4lJ+K+2MBqWx7+Ws39QxexHcdY7Azv1J0r89rCC7yrq+6q92MroKeXz0CbqtnofrPbX
 lxiYX11uksWQoLlRT6kz9CBV7jG9p14Xo5c/KJMbwUZqFY9hT7QAimQnTFFAF2Rcv6BNJFZFf
 RaGBdX1XTCRuHusXywn6h5CNgQvHgm1+c58OtXH9GxApX+jCU8KPca5qi16Xd0p9tdvETGuXI
 OooICzUxqa2q3XyooovVxEtG+KAVppVqBYUG0pJEft478DUxROzV2dnCLPhvRXiTOnZR7Eogc
 zoWalmVr9yMNvQp9fAdbFPM/Bjmcom20G59RyAxBAxQ/QUBCG0QsJfjO/HZORIwhTtLcrstdV
 0xBllrunpqGAKDiL+dt6s3YJ3XetgV/+dRHBoCg+bA8Jq6hlrccgKzgyGEwZHEYDWk/gwVDFe
 PoJG1g==

>> Two resource allocation failures triggered further actions
>> over the label =E2=80=9Cdone=E2=80=9D so far.
>>
>> * Jump to the statement =E2=80=9Cndoms =3D 1;=E2=80=9D in three cases d=
irectly
>> =C2=A0=C2=A0 by using the label =E2=80=9Cset_ndoms=E2=80=9D instead.
>>
>> * Delete an assignment for the variable =E2=80=9Cndoms=E2=80=9D in one =
if branch.
=E2=80=A6
>> ---
>> =C2=A0 kernel/cgroup/cpuset.c | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
=E2=80=A6
>> @@ -973,10 +973,9 @@ static int generate_sched_domains(cpumask_var_t **=
domains,
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Special case for the 99% of systems w=
ith one, full, sched domain */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (root_load_balance && !top_cpuset.nr_=
subparts) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ndoms =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doms =3D alloc_s=
ched_domains(ndoms);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!doms)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o done;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 got=
o set_ndoms;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dattr =3D kmallo=
c(sizeof(struct sched_domain_attr), GFP_KERNEL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dattr) {
=E2=80=A6
>> @@ -1123,6 +1122,7 @@ static int generate_sched_domains(cpumask_var_t *=
*domains,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * See comments in partition_sched_=
domains().
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (doms =3D=3D NULL)
>> +set_ndoms:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ndoms =3D 1;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *domains=C2=A0=C2=A0=C2=A0 =3D doms;
=E2=80=A6
> Please clarify what this patch is for. Is it just a cleanup with no func=
tional changes or is there a bug that is being fixed?

The development opinions might vary for the presented transformation.
I suggest to reconsider the number of relevant variable assignments here.
Would you categorise an extra statement still as a desirable implementatio=
n detail?

Regards,
Markus

