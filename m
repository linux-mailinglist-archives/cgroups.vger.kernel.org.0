Return-Path: <cgroups+bounces-289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424537E7367
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 22:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132931C20C6C
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422DF374CF;
	Thu,  9 Nov 2023 21:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl4sttz0"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83E374C2;
	Thu,  9 Nov 2023 21:09:19 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDC3D52;
	Thu,  9 Nov 2023 13:09:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cc53d0030fso11720495ad.0;
        Thu, 09 Nov 2023 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699564158; x=1700168958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbET2W3dUryyc+oqm5spJ6Bpe/uDpFznsmIpTGnoB9E=;
        b=Gl4sttz0+etZ+tHB4Wdlp1+laHRS3fjDd1v6wF92e1SslbEC0vlIU5NQABOvrhTf7D
         JLxXWjK7YBVSbUrLIDkfMIEF0yG6/gMx8ZG7Srr/sOQWnST1fYGAXMFK5NGtMf/u6gGj
         BQN3vUkAYBsPG36lcnOD2Ctgw1sRH49rwkeDYzX/Jfc8+EhT2DFWF0PDqZDpLqgbALV3
         B3JHhP68a0dCC9JMAyu4FlZOpfgpnlfpDxUUNHI8gKM/TzohCBkq+0Kuf652PmhK2Lz9
         9n7jZOg/m3tegnJSCOsPUnl1g0xmnoy991Q3uIPjBMvvuXaCfPhpRScCfFSnPuDmPAhj
         oQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699564158; x=1700168958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbET2W3dUryyc+oqm5spJ6Bpe/uDpFznsmIpTGnoB9E=;
        b=WuEgA87Cb4oCGBN0NCa+ePYGQi9SRPCZX6/FZJa2vMcBaugHIV3aWS/d2tk0rjDf0q
         GxQcK+PsMVHhCl+ooePZEMDPPQgW61bCO1L1390khz5YmzVq9Wf+t7pxl3MSCq63jd+I
         EsW7ud3btODcM0Niz2EA8iithgWdb5bKAe2M9JKEBx+l7vXrPSmf7qoRu5/qVGdRNp8x
         iYYDaWlOZVdbHIErE2HJDOxmVar2PLz/iBfR+Z88YpfWprsLJzhmr8yF87XVdrINaw8B
         49peA5swk5aDUCsMzrOKll3z3JJFq8WHPJTbnKSdCosPd/Sgu5qx8dxTeL0RYGPxwkFn
         HoWQ==
X-Gm-Message-State: AOJu0YxDrLQx0HNYLBFYYmmFPmqIuYjQtE1EFVJZHsk5Xwm8hog5TDti
	kTtDgYjrDarP34xV2YQrW93fdVr7/JU=
X-Google-Smtp-Source: AGHT+IHr5asmr7Adfqt5Wgvx370yUyMQWa9XAprv8dDWwOuWt96EjfvmAZnPINtvb+RWJpM+VJSx5A==
X-Received: by 2002:a17:902:ecd2:b0:1cc:4e46:1de with SMTP id a18-20020a170902ecd200b001cc4e4601demr652512plh.18.1699564158204;
        Thu, 09 Nov 2023 13:09:18 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b001cc3f9b70e9sm3938994plf.220.2023.11.09.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 13:09:17 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 11:09:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 01/11] cgroup: Remove unnecessary list_empty()
Message-ID: <ZU1KfNvMUt0QoBjp@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
 <20231029061438.4215-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-2-laoar.shao@gmail.com>

On Sun, Oct 29, 2023 at 06:14:28AM +0000, Yafang Shao wrote:
> The root hasn't been removed from the root_list, so the list can't be NULL.
> However, if it had been removed, attempting to destroy it once more is not
> possible. Let's replace this with WARN_ON_ONCE() for clarity.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

-- 
tejun

