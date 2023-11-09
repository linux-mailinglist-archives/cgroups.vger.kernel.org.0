Return-Path: <cgroups+bounces-291-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC4E7E737A
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1711C20B10
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6484374CF;
	Thu,  9 Nov 2023 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxhEr+wb"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0037175;
	Thu,  9 Nov 2023 21:20:33 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4A3D65;
	Thu,  9 Nov 2023 13:20:33 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1ef370c2e12so755731fac.1;
        Thu, 09 Nov 2023 13:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564830; x=1700169630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vDa5MQRIsHQMlj4ernAkvms+ULmkUff9hpRlwrz0iFA=;
        b=AxhEr+wb99fEVu8AYPKBdgEfNUvaa0KSaeRz0/vXoe46l7q7/1arGPEvYXTm3l1E9m
         mMLqE7SfTKoxVLR3ggTTH60MtOuoSICE7tpmTsX49FLgLiNzDiGn2ocg2yYCq5ocloPJ
         SGyLFnJ3blu0Nem/FuNmAPFLpW4VoSmEkHOcun2hjdjRseBcp+ZnF/b+CYemPA1mHjnv
         ELnIEAU196iQan4/nRdfQM/Hzp68TZb5uUPwAezLtfskE0kf51iMQ4ChkphO4XWnLigG
         xIZCz6s6w9wiBswvs1DZ0qaTk49i4gqoBKgq+EdBp1OuGoA9WV3Aq36PsrHD3/GZENck
         Y9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564830; x=1700169630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDa5MQRIsHQMlj4ernAkvms+ULmkUff9hpRlwrz0iFA=;
        b=efMeCuNv5lOtjCR5e1r5sYuo7nH8WOK2wpMTn7QeQ/bNsnRhFYXyB0hi1BIN4+0vpV
         j710AONyJVKE6zUfQlKcZcxucEx2fEGqsDDFmvwBsiiBQfIGxhUQPi6VcX5lKfER+lqu
         UQqHzDKgxGI/Eif0iuGsfeiwra8/4ANMKqWAPnPA2CfkDEj4p28pvpjWyurEvonGtN1/
         yQV5oLAxlHFilvVqTUQwBHnxdOLQzGbj6sn3llvfNm0le5R4ky43+wdtVPT+KCJUMpIV
         KtkhvapmdzIEgyq8xQBEdRYJpl5OxGmJ2dRQscbBxxyGt2Ev30hxkDyB5Yf1CPXsbUbf
         NKag==
X-Gm-Message-State: AOJu0YzEBxwX1GsELWVTCpkW19W/sVlDBaRzb71x1wKcQK1s9JsZkZms
	vqkqa7SxPGgsw2GOhTDTbtg=
X-Google-Smtp-Source: AGHT+IEkj7r9HBWiYoji1szEETzcgvitf+O8JPdoLS6Et8s+OONbAhx9dNiIAxc0GEltOYA2QKXAjg==
X-Received: by 2002:a05:6870:1042:b0:1f0:656b:5b99 with SMTP id 2-20020a056870104200b001f0656b5b99mr5704847oaj.11.1699564830420;
        Thu, 09 Nov 2023 13:20:30 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id q4-20020a056a00084400b006c4d2479c1asm157498pfk.219.2023.11.09.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:20:30 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:20:28 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 03/11] cgroup: Eliminate the need for
 cgroup_mutex in proc_cgroup_show()
Message-ID: <ZU1NHNigpHMB4FT6@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-4-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-4-laoar.shao@gmail.com>

On Sun, Oct 29, 2023 at 06:14:30AM +0000, Yafang Shao wrote:
> The cgroup root_list is already RCU-safe. Therefore, we can replace the
> cgroup_mutex with the RCU read lock in some particular paths. This change
> will be particularly beneficial for frequent operations, such as
> `cat /proc/self/cgroup`, in a cgroup1-based container environment.
> 
> I did stress tests with this change, as outlined below
> (with CONFIG_PROVE_RCU_LIST enabled):
> 
> - Continuously mounting and unmounting named cgroups in some tasks,
>   for example:
> 
>   cgrp_name=$1
>   while true
>   do
>       mount -t cgroup -o none,name=$cgrp_name none /$cgrp_name
>       umount /$cgrp_name
>   done
> 
> - Continuously triggering proc_cgroup_show() in some tasks concurrently,
>   for example:
>   while true; do cat /proc/self/cgroup > /dev/null; done
> 
> They can ran successfully after implementing this change, with no RCU
> warnings in dmesg.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

