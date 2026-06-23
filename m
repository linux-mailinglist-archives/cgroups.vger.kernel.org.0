Return-Path: <cgroups+bounces-17186-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dw8JEzSxOmoLEAgAu9opvQ
	(envelope-from <cgroups+bounces-17186-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:15:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A18276B8A0C
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:15:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gourry.net header.s=google header.b=J9zhV3lm;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17186-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17186-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C1A3034BD7
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F7E30DECC;
	Tue, 23 Jun 2026 16:13:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52B30D3F4
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 16:13:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782231211; cv=none; b=Ieg9/+jeMCplhk8ZGweUOJPQPbslzYJR+BKhQnZfgNB8b5bKbGas/63KzfBA7QiyQNQWLhA/qo3w3xepPS4DKICV3XAmd5uCXOs2wqU/3I9pNgJ/qth5cCv2K0YyWv1svu2yXYJ/376MItg9GXf3mPbRqtuuHnxwJ93inqfGOys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782231211; c=relaxed/simple;
	bh=rB6mVYXXDHOlR5uCYK3SgikrRY57JV1RdtOiSeVXDR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQqjP/IQc0nRpxp0ou022K44Uu/NWxLG2j07LJ87lL2oWjhE4q1ZGG6Z120/NJ0ZJNbELld2z3lmoaFwesMY1C3LLrXXRDG3ZrikbaEFZu3dHZPSsMOg6IfMutniD4KOOLWnkTWrdkViHfUSXNNepX29OV5xKFeOY41A9gPJ1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J9zhV3lm; arc=none smtp.client-ip=209.85.219.50
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8e066990ff9so645356d6.0
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 09:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1782231208; x=1782836008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1j3KoSBiivnqdcrOevh5ULZphp+5TbYQXFTFY6Ui8zY=;
        b=J9zhV3lmXoeU7nvc3MKhXdEpylvsr4u0hZ1uyZcscx3b7S8zJD3LjsAZnal+rcoCp9
         +PL9CTvXQqjXYG1RqOHsgH4gG9JTOuyj3/5pWXaAwEY6iFwc/GRas7ihEruebIV5ryMd
         N1/ttXvvJbdyXxzOVyUWqQn1KqS855a0f6wqaVjeQhtPYJ+vHkm11Y9a5jiw15FLa/Zn
         a6c2JfsA4VNyKsvTi4Cuiqbvjt03DRfY0FAEkQ/znIQkXX05gDFYM8o00Lfy9HFkqeqx
         /3VgiWiRACScAPLfdAeQGr5WZzgx0ya8ScWxkLkyljfmSjPRSandNWVwWJBSenUXLVt8
         WSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782231208; x=1782836008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j3KoSBiivnqdcrOevh5ULZphp+5TbYQXFTFY6Ui8zY=;
        b=EycD9Gyc1QSItnU9xdaTa/1Fu/Ry+QuRwHGI2PF5nZMdXWinrUdLMiWIxiRyme0Pq3
         Eb2J7C7QRW98OibLOKCMq9OHGzHz0Xrfks+tXz8AmnccnvYnU4gMSEbUyYCv0CUC3/59
         L7ypaCe8Xdax7McCWzeePms+c1tUe9oZ4qCE0RjqibJT5BnvmQ/DVie1MXoBiY1OV33a
         +tXFxZ0XVUQy+23b8kN6wH1A1I3ceXXu8st7+4cXfeIo1pDJABh/UoPR0jllehiz3NRK
         8t4TXnVDwpRnq/TskKsex7Jbq1FNvqsgvS9hh/U8qYOdy6Yj1euoH+n4V6uJZxvIBLhM
         hZLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqpcg9wIOiSsbX0m65xi3981KEz8U6uIBJgnOpD+0u3FC5zmdiPrE9gdZFTL01ChK5xMendxQIR@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEPBjy1sry7ai9HEOrMfopOAzH3xQwj3JgdHF53RqzoQBotDy
	3pvAyD0LzxeyBAkXgFNw5KFBva7YKbpxy9Ss5wm7NiOJmdeQyj7q7g42vvYdOezvwpk=
X-Gm-Gg: AfdE7cmKSYoEK6tdQAvde6V0jpNXNEoxS7Lyy3TsyGCLTHvxw8jiWXOdHpOnhqjXOOc
	BWwh8T3jkhfUk36wk1HkgrBIm20brBWZH1f2wfNxm+iLE/VwVbyauGz++4kgo32PTf7aUv9NL+k
	Qchlfoa/y9Kqeb4s/42Wb2VnNy4z7k1/GSQXLS0DbiFhxCUOuSpK9PDaTZ6l5WBsj3c0DPdusx0
	CxTFIzYKCJSXgMSKkSz5fkZTaoEGVbVSEWCxukp8e97dwTxcI8g6tS4N+63bqixtoY9iJ64mtHI
	co0rYBF+w1ilgEgETeSNbiqTnCSVonGJYGRazplpoEKtdLkPfoTCczLVQwEMBpC01tqt3ytNlyX
	u0yIQcDiDVDTL9XlrFXEnin6WrW9Wd58//NhsE5gasjDaLNPkqpO21m1reiC5QsHzmlyhuToJT4
	AWAhztJcJjzJIVkzDmxideK5nuCKYMYwOgkXG35E9G2Om+qgKuWa36AtzYAY5tdYtpD2Ge
X-Received: by 2002:a05:6214:5144:b0:8d9:ceb7:3ae6 with SMTP id 6a1803df08f44-8e3b6e146dfmr50627616d6.15.1782231208098;
        Tue, 23 Jun 2026 09:13:28 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f016d5esm127912366d6.10.2026.06.23.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:13:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:13:23 -0400
From: Gregory Price <gourry@gourry.net>
To: Waiman Long <longman@redhat.com>
Cc: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Li Zefan <lizefan@huawei.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
	Guopeng Zhang <guopeng.zhang@linux.dev>,
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/9] cgroup/cpuset: rebind mm mempolicy to
 effective_mems, not mems_allowed
Message-ID: <ajqwo58EJksSNuNE@gourry-fedora-PF4VCD3F>
References: <20260621032816.1806773-1-longman@redhat.com>
 <20260621032816.1806773-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260621032816.1806773-2-longman@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gourry.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:lizefan@huawei.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:david@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[gourry.net];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17186-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gourry.net:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gourry@gourry.net,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gourry-fedora-PF4VCD3F:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A18276B8A0C

On Sat, Jun 20, 2026 at 11:28:08PM -0400, Waiman Long wrote:
> From: Farhad Alemi <farhad.alemi@berkeley.edu>
> 
> Creating a child cpuset where cpuset.mems is never set leads to a div/0
> when a VMA mempolicy with MPOL_F_RELATIVE_NODES rebinds in response to a
> CPU hotplug event.
> 
> Reproduction steps:
>  1) Create a cgroup w/ cpuset controls (do not set cpuset.mems)
>  2) Move the task into the child cpuset
>  3) Create a VMA mempolicy for that task with MPOL_F_RELATIVE_NODES
>  4) unplug and hotplug a cpu
>       echo 0 > /sys/devices/system/cpu/cpu1/online
>       echo 1 > /sys/devices/system/cpu/cpu1/online
>  5) mempolicy rebind does a div/0 in mpol_relative_nodemask on the
>     call to __nodes_fold()
> 
> The cpuset code passes (cs->mems_allowed) which is not guaranteed to have
> nodes to the rebind routine.  Use cs->effective_mems instead, which is
> guaranteed to have a non-empty nodemask.
> 
> Closes: https://lore.kernel.org/linux-mm/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
> Link: https://lore.kernel.org/all/CA+0ovCiEz6SP_sn3kN4Tb+_oC=eHMXy_Ffj=usV3wREdQrUtww@mail.gmail.com/
> Fixes: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}")
> Suggested-by: Gregory Price <gourry@gourry.net>
> Suggested-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> Acked-by: Waiman Long <longman@redhat.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Gregory Price <gourry@gourry.net>

> ---
>  kernel/cgroup/cpuset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 591e3aa487fc..b21c31650583 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2653,7 +2653,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>  
>  		migrate = is_memory_migrate(cs);
>  
> -		mpol_rebind_mm(mm, &cs->mems_allowed);
> +		mpol_rebind_mm(mm, &cs->effective_mems);
>  		if (migrate)
>  			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>  		else
> -- 
> 2.54.0
> 

