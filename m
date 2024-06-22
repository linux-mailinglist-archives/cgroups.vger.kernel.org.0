Return-Path: <cgroups+bounces-3280-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E632791343A
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 15:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E531F23254
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAF816EC0B;
	Sat, 22 Jun 2024 13:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LAhhFSoA"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3461E485;
	Sat, 22 Jun 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719063978; cv=none; b=Rl40Rbgaob90r2xqoiSuZywFyUqNjfKiyi7+KykKLyPt5QOzISt/PdToMNVaWS+JywO35mRMYn2QCnFfiWuioP2PunEfNwq5pQ3aHajRU1GSomjmLwudkOd6pkE+7+efhc7e8WyhasI555/l0IIumwUhIwwk7Zp1Lp6gr73qSSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719063978; c=relaxed/simple;
	bh=+d6ry8ShdrEqtbS1+VTAkmYE/FDL5yTFgm29o1to6Ho=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bDUHFCTzviEno0M+zGIjz/J4MnqXtPZQVZwCS1+zyzG1dHnaIY30cks68NPk6a5RYlmZJ2C5mMkS9JDYKxqARAQsK0QMev2k4JJtgmHYUG+7KmP9i/HeDsW/zLZEzjFD8763ktb3RCfy3meewNrObMHTkM7xtA66PysxGmX5mi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LAhhFSoA; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719063918; x=1719668718; i=markus.elfring@web.de;
	bh=J0A+T/BFJA2HV503DIR76VhyTM9gtllwzv0/WiNxCb0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LAhhFSoAdr4Vqw5gHhPQ1h+wDIFhrMyGctnriQebCIkhnvhIF9JxdZHaA5c7c44a
	 HSsbw7XoB3rH/fa+dl0+Hn19P2GZQ+DttbYfRUZDPkibi6HoeU118VIXvkn3CiKZJ
	 GGRy5cUvDT/y2E6ishzvUlEp3CHlRxH6d1pbWXhmYou5Osihy7M00f4jc1IPg1U/W
	 sWWQHwg3F/IkhCrJOqLna2t0hM+w7il/Jg1J83QpOMseCNal5BPL1p1cXlvQIpEOE
	 vIFtvSHPn/UjoLpr83DlfqncLs+l3C//wywgu/sSJheqzfRGl8FfADyADFfkkdAfa
	 g0pl6fU3urolrZ6EXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYLig-1rpcOS0mRe-00OXUh; Sat, 22
 Jun 2024 15:45:18 +0200
Message-ID: <e1e51582-7ecb-40af-aae1-498993d0f935@web.de>
Date: Sat, 22 Jun 2024 15:45:15 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Ridong <chenridong@huawei.com>, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622113814.120907-1-chenridong@huawei.com>
Subject: Re: [PATCH -next] cgroup: fix uaf when proc_cpuset_show
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622113814.120907-1-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Evn4r8gxlYLcw+BcF1xPz9OY5TfNrVkhSkt5PjYb/Q1TnVVyvYs
 hAM5bBJPLuYOM+NKPcD0mdUKdyAbrd79mAwd/0sVmu79bRRXD4E0vVU0y8RhsNGD6P29i6L
 zlhZkT+CHdrTF9g5ANO08uyVVTCZT/gcfa9KAPJNrGMdCq35hCKmKjrujQh2Ed1WTYqzPrO
 iPbhkoTzybfd3WlXjM7aA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L8Mh94X4KOQ=;aHCWYiF+0dkk06gAbdwSQQmdUVc
 fYwtpJmHdVQdJTlTpazyiKdMgiZjrn1XxwOuYhL+pQY/kVBU5SZ5jbcAg3ctO78Cv5+FVzfhq
 S7UXmDONeyvBfJFrXIEjI8v/0d+v/18zGLHdu2Z5uwGN6wj3kwRXr36N/ouFUbO++XA+Cri6f
 hd+PLdTI5LrvO5gkIFYvE2wT31Bcr794p0tclWSMJfyZsvag7TCzODxRH7jorlW9GDXOlXvGM
 ysE7YLAp0rywXy+oMC6+58Fvhj+jU9kE6wDVQ+cs2RNSA1J48Gto6PJoxRIvtqiHZ3og4DGwj
 tG4gEaccvDMzYyBUKVAGY/akSmBV0Si3YmvF0jJi9Txi8nAIyUUFce5PTL4BpKIfCm5CaOjOx
 KUDvch/TL2yENbReRWVhU2fzbLgFVF9dNlUMQPadoXqq+NprwkPcsaq6bWeWEp5TDw/+PEAZA
 lZcE6itsdd72m8FVGGN0HBc1JwBMf6r0ROVrtvZBD2UAX1t9UHA9n6BsE5KoKo8WLyInTnHh3
 vyGBppc9QdgiAtg83UBpV4nHx09ld9BaLEgSp1h3M2klHsNmTtrJ1Fr5wNpdWBagVN4nhpTWt
 pVp5KbGXL64moV8GbFcKJj4OC+uGP2sgtY4I4Reaa3kzNe7i7wGCuHZjk1dPEuqgjSsodBExG
 Mvgy3QHQMKZSJ8CqNaNhMKh2V+zvglBVE0hI10rKzWX3luVJJgeho0w095aAHtCu0megB3ZzU
 deDK+1Ax30KxMtLoxEAaiv1OmE8veRM3W4MVLrrcwIYZQTHEiHnWg2JgGcCEjY1U+dmIoRQSZ
 fHg9H7B5LJRrwwxmKu+73uSMfqTuc2ci3EtGwQ8A5uG8M=

> We found a refcount UAF bug as follows:
>
> BUG: KASAN: use-after-free in cgroup_path_ns+0x112/0x150
=E2=80=A6

How do you think about to use a summary phrase like =E2=80=9CAvoid use-aft=
er-free
in proc_cpuset_show()=E2=80=9D?


> This is also reported by: https://syzkaller.appspot.com/bug?extid=3D9b1f=
f7be974a403aa4cd

Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D) accordingly?


=E2=80=A6
> +++ b/kernel/cgroup/cpuset.c
=E2=80=A6
> @@ -5052,9 +5053,28 @@ int proc_cpuset_show(struct seq_file *m, struct p=
id_namespace *ns,
>  		goto out;
>
>  	css =3D task_get_css(tsk, cpuset_cgrp_id);
> +	rcu_read_lock();
=E2=80=A6
> +	rcu_read_unlock();
>  	retval =3D cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>  				current->nsproxy->cgroup_ns);
=E2=80=A6

Would you become interested to apply a statement like =E2=80=9Cguard(rcu_r=
ead_lock)();=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/cleanup.h#=
L133

Regards,
Markus

