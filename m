Return-Path: <cgroups+bounces-3283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F19135EE
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434E31F226F7
	for <lists+cgroups@lfdr.de>; Sat, 22 Jun 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E954757;
	Sat, 22 Jun 2024 20:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tSPgaf6k"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A817C77;
	Sat, 22 Jun 2024 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719086703; cv=none; b=b9F7HxihfGCAWsw/0boTu+G7qZFFvsbjpZQXk2+S/JOYaPztZOXfR8W3Rra/0Wqs5UeFtbmiVFLI0h+20FB1Zog8Q/MfRZ3x88VNjHbd7guTzU3Qzg2e1hAEb40fE5onElYudHwFk8xuqUbi6W7ptjnl0pDv7cFbuQLA97qfoew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719086703; c=relaxed/simple;
	bh=X4RgHk+3bVHnxuD2bSbdMoym15SXyvRoyVUwm72nSeI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AAUKNHryHj+iMbKKOpPfzzAfhzHZu3qyCh9h+23GTjwpEyENkjZEpDIl2QpJDVCtVYOsN6RKEA5ga/TewuGYB5hlNX9he8kLK9BJn39zjOVUOj5rVUO1B1E1MNpxLtEbw0dCrBNpc82Zfp5gokkxcfLMzqMMQaQFCYOmjwvq28U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tSPgaf6k; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719086664; x=1719691464; i=markus.elfring@web.de;
	bh=hXgtTs8/oQjFNPGrQzuOVGSfq9fteLe+XwONIn/tpL8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tSPgaf6ksSJOkTS7u67G0pUatIUuoRfWh4IxfmZRA2gah6CVIF9r4ywYlyGnGDHT
	 wU2R1xuFoHriU42lBMhY4m8xQFSGJ62ybHJQF/8Zi77ne2L8pC3E8seLBE9IgvcbT
	 buskwHI3SAih5p8cVvqNzcjKkQRPtQQiITyQCaD3WVa6OdnTZ96FHmxSPzM39ODm1
	 4MEOitlBV5UxYUcShlLTsaI9Twa+K3j/Kdekk7ib55sZnLodwR9r+rmJFnlTj/2Yh
	 dwhrFfgOM9Z3FYBpef4Xpl4ceJBVMQ9QEE/V8PW4tdv6czk/wNUuVfu6QBk0IIvdF
	 VinWWYbGTk+FFfL9UQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwjK2-1saAok2Qpe-014Pns; Sat, 22
 Jun 2024 22:04:24 +0200
Message-ID: <b8792fb5-9efe-4dfc-ab61-6fa55a4b0d51@web.de>
Date: Sat, 22 Jun 2024 22:04:22 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 cgroups@vger.kernel.org, bpf@vger.kernel.org,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
Subject: Re: [PATCH] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <19648b9c-6df7-45cd-a5ae-624a3e4d860f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2nyoN8Z62wxbrejHqKaRXiE+pJnEiesY8jOD9IS372zB9RDTIzl
 7IAL6xnS5vnm7uoe51I9MZIUFXPHJCIN12f3LXaTNWEmUMHoEVrNLr+0I0wp/2Rz12QPUAE
 4z3EgONNZvaUXL6sIoTa2ps/ACFJYMX9+BN8LHQA1r3E7AnC40MG1K1Q2VQGKvLOUrBXgrW
 L5SDtpRyuOiKAfB/dSzmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CHw2DvHij60=;F6AxIGuvAiFS9CXwETNCF/0xa9l
 7bM6pzpPMCX3mwsDBOqhdjne84Mw17Vfv7EUcAErGbY8kTW6IcjQK5AVeehLVLy3EK8WV5G4k
 cUluvMGYDXWWnEqp2e2Q6IkhTS/Fp75SlUdFz8fFuyHhsZKTIdhGfasZXDfUMRbD3PzydfEQO
 +a9PvEAc4V0zxk1YGZMNZtHoMq/vpV5fkIDnX2KQx8Mt8UpdN8lWzYzcqAyspYu4I9HiUUu/H
 NO4n3bZLSVga7zBQeBbNuSTniArwVmKWaUtP58yYvwT3UCrXr3ILXV72xFHwBL5+b5+eWq9ve
 WqsmlR6ISXX6BTwdD/JrxPPg9brnmDpajLQjW49Qjzwp9j9MAuFhgHsIX100okYD9zgS3D9k4
 UVqNOagVMojD70iIaK8nGpx25ot7yA4gZEE1zXPA39rODqH2Ffg21oGNSEhPP6dQ+JKr7gHd2
 b+JO5CP/R9bLAKBvB6cTYx/LSitajAlXqVS49vlfdFACz3ygvquMH2yU80KqmgOJkDCnPND+W
 fWx0LFP+gM0AN195ywuWH0Z6GaXlMqk8Ler9rKuQsW6dNFmO7h+H6umoywJmGDAs7yFfrByAs
 PnxXnYDT9cGeNtxT6w1F/akoTWmham2PXlBLDg2unYkYStHM67TYvhlu0DNv4viddJk9NOODS
 QZuUwiDaaB5j+8bjF5LSDbrWhO4fDz5q9VyFgCK3u8YDmj9kioHeY3tQPsYSdLQSaUHSgULRT
 twttVMd1BzDUVkE0Eda4uvV6PofQYgR18wR8I006uj/9pkDGlnl/60VAlSOZXmvnbKxzVWmIz
 JqjENw1MPL5CiQAWk8doqWUaTsKOIAxg8QbEZjM2GwUkA=

=E2=80=A6
> +++ b/kernel/cgroup/cpuset.c
=E2=80=A6
> @@ -5051,10 +5066,12 @@ int proc_cpuset_show(struct seq_file *m, struct =
pid_namespace *ns,
>  	if (!buf)
>  		goto out;
>
> +	mutex_lock(&cpuset_mutex);
>  	css =3D task_get_css(tsk, cpuset_cgrp_id);
>  	retval =3D cgroup_path_ns(css->cgroup, buf, PATH_MAX,
>  				current->nsproxy->cgroup_ns);
>  	css_put(css);
> +	mutex_unlock(&cpuset_mutex);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&cpuset_mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L1=
96

Regards,
Markus

