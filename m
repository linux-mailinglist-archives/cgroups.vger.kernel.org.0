Return-Path: <cgroups+bounces-3290-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077C913849
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 08:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C40E3B219E8
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 06:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D701DDD6;
	Sun, 23 Jun 2024 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nN736/C8"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED71642B;
	Sun, 23 Jun 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719123569; cv=none; b=LR+7q5r4uJvBTz2/0SUXKzWkgSGGG2qljDxYeBLPAednVqsXrwhV8oqUFF1EBcJIbI9/Ie7xbYbiozOPQOBQQgr+VqTYjKNN+QdtAq991m8pXkVEsywmiesHgMaf3VKKjnFyXudw83iUHA0++yBMtqm1rY8ve0kT38e0cTS/Sp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719123569; c=relaxed/simple;
	bh=V0UATKgzQCJyNTM8vj+JooVAdAm2yTDAF4DwkRjQzEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btND0t9Y5fOymtK0SSEH2c4iHYOVIR8zrm+nSjU9pRWMElVuX45r4n7SNqVF3gvQe627eE3HH55Z2efs+vpRDd6Sn08O9vS9/er2lta6hBclJbBne6/14S9+1DUJ2gsqgD5SoRlttvKeI4VvQux1vp2e87GGKSiTUYX3CuqPlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nN736/C8; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719123508; x=1719728308; i=markus.elfring@web.de;
	bh=V0UATKgzQCJyNTM8vj+JooVAdAm2yTDAF4DwkRjQzEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nN736/C8JdkDuLTLAzdayI5U3KbGyE3rL2RmVp+Ck/WhzZJYNJ93u996wWokdgKD
	 EM+PM+JGzTm4GMKJomy1InqpBLHGb3F2upsd3NarAMGP1fn3RA95WdJIUWNn2T6UY
	 i99BvzSFTDCgvZdiGoEuKZwKg0whLyiW4p0ASUYuRC/4C6wd2H037FiVC7bOAQXDu
	 wSKQSgao+OSRWZ2vOMikXt0lqkgQx5mDsARaZByqVhhNSXTyX+DCVxm7Ll4kbUIiz
	 iHldzdUyfpS7jMdNIXybrPLvVLt9BakadHckCFSN8bQdOH/cb9s0gcweSKcghgD61
	 GtGZ4v4VQ4+FM5kfwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKxV-1srH7X0grT-00ip77; Sun, 23
 Jun 2024 08:18:28 +0200
Message-ID: <f40c4a72-0c6c-4846-a926-ba1eb2763697@web.de>
Date: Sun, 23 Jun 2024 08:18:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall
 <julia.lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>
References: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
 <b8792fb5-9efe-4dfc-ab61-6fa55a4b0d51@web.de>
 <2c70eff8-c79a-4c99-b8db-491ce25745a0@redhat.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <2c70eff8-c79a-4c99-b8db-491ce25745a0@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jq7ZW39j3wEju2GVUM+Z3wMVJHeEmu/JUNKYO8qE2t6Wp/wzmSf
 T0prBekXOsp24uHv60gM8zYgjHUKo3fkVrk4GjEH49j16q7re7xbHhNf+yv0KewWXM5dF01
 EuubRgfyOIvy4mdPmKv4VGURmxJ7grG0mYPX1mRf/GyojFKMmqx0fxuyl+1d6Be7HFx0tAM
 q7XvvxsL0c08HKMu15urw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EfJ0vb0cp3o=;XT+W9e01g9weIT7HDgHNNSB+SEf
 br9qQEkr84cidj2oeQ46/0eCtkzebnan2DChB1GNqrC6usFEhIpd5mJ4EE4WWA7u2iBImRZ+f
 IG8zDIcFhuF2DX7Yq+14LNNxET7v1PVSkYE7MaNgOIc3CDc2/A9kBwP74Pctuar4URwPXzj6K
 zKhqvtOahp+V3RovMk+0pKlq5gAh2FBcbfrm4DEGbQkBOIR/7zVc+OTYUvhFmdeM29PTwl3t0
 EzTu/kZxA/02OK08kSMj6cJJApidpHKGTSrBfGjJPXnE3kjN6WLXv2By3Uyyow0xnzdQXjEgH
 M4Vy3j0smin+CNYItfmdTYiLav6Xxq1SvCyt12KzONXXKGPKiff48QSg8oAsyEQ4rigpTydpN
 n87YoDi8B1Os1pOgRi7hax2INf5VWsfCtrn2SVSXI3fslPSlZy/1eDiqroHt42Oy+wll5FNOO
 zpWK+Io6Cn0VcZ4snoE6ZxqfCUKu8EMi/6SfrMEDV8dulfiNOKNAjKRoCOMHWB0guNZ6WJIlT
 C6FqtDQ12qWXzToK84lfwytRA7vUjH6wqLGoWnY2aVMuCSJr+iRLj4L8JRDzbRHh4bJzcJqUN
 Hl9fKp4p80Q5VAT95jSsZaUpXx8Tn6Thu0FvVO+URD1MBD/NopKlOcg2pZ1BOkTtw0BhhmyJt
 VeVZeVGvE9iqcpQKwJkwNApiUUQ4K/UDCzq47/AFrXMw2R35z5lT30BBtGnzYXqcEgeqmQcLa
 nDjjoa5y3XtJlOXhQFqxI/bM3w3mtmJwaEKkErnLzNG80HXbkIHceNtHFUPA5mE1PeBCRmwRO
 MAOPDjL44YSb+y0gvdVdYUl9mqC2wh2a6dhuzbEseJrXw=

>> =E2=80=A6
>>> +++ b/kernel/cgroup/cpuset.c
>> =E2=80=A6
>>> @@ -5051,10 +5066,12 @@ int proc_cpuset_show(struct seq_file *m, struc=
t pid_namespace *ns,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!buf)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>
>>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&cpuset_mutex);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 css =3D task_get_css(tsk, cpuset_cgrp_i=
d);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retval =3D cgroup_path_ns(css->cgroup, =
buf, PATH_MAX,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current->nsproxy->cgroup_ns);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 css_put(css);
>>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&cpuset_mutex);
>> =E2=80=A6
>>
>> Under which circumstances would you become interested to apply a statem=
ent
>> like =E2=80=9Cguard(mutex)(&cpuset_mutex);=E2=80=9D?
>> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h=
#L196
>
> A mutex guard will be more appropriate if there is an error exit case th=
at needs to be handled.

Lock guards can help to reduce and improve source code another bit,
can't they?


> Otherwise, it is more straight forward and easier to understand with the=
 simple lock/unlock.

Will such change reluctance be adjusted anyhow?

Regards,
Markus

