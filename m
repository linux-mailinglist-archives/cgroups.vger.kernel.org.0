Return-Path: <cgroups+bounces-299-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA57E7522
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0552817BB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 23:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C50D38FA4;
	Thu,  9 Nov 2023 23:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmuhGX8k"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C038DEB;
	Thu,  9 Nov 2023 23:28:47 +0000 (UTC)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC783449E;
	Thu,  9 Nov 2023 15:28:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so1273010a91.2;
        Thu, 09 Nov 2023 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699572526; x=1700177326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Us2ffS4QTU1pgNRgHdf3Fo1HO9IfcWjYxJvOBNAJcPw=;
        b=SmuhGX8kG0DGPzMhd0Am6/CaBSBBVOeU/53ebgbqtYsvcHQLyRufCNLAk2lyuD/yW9
         dOJkGJXRiyN45nWHFcftK0tyu8sQoizRMrsskFTVrZ1AnGQ8cJhZz2W69lMV77s7KfJq
         rIwIzwxTjME3jVs6b91xZPtjdLeUhuQBcuVHal/8Y2Y8dU1tur3VaMaD3I8orYH8mOsz
         7toqUrDl+dN36XrYmETSMuUVk51jfmoKT6gcwiXaeO8R2qe4vPu3dlHJV5QddXAAQZER
         3BzRfFYKDIu/NhHEfIHb1JC+Xl4fV5Zy8Zjlpm/E0sWsabALfBbGSrWyU1VGDcdAgECP
         9DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699572526; x=1700177326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Us2ffS4QTU1pgNRgHdf3Fo1HO9IfcWjYxJvOBNAJcPw=;
        b=Vk/tG6lQlKeCR6Gmw78ri2p3XbI2xwhjcDu2VqM5z4i3QCCkNos4JfAoBhBZqGMtnu
         9nkGHd8y7yrsPRfar5QxThXDGzJ18AR/CkJzT28SvH9k6BsMTihNoE5Xh6+/W6eAAwMk
         EHted8cQo/WIgsJfaHZFbXuS/z5AybJw/uV268m8xK94oBueZ4L/cEuWTPBpxdnUvDMF
         +hEtE3kzo/gKhhQsXWFSUphc3jNjNWsrNJpfWdzjK6P9AlPt5Lv9IZ6s1px7F5+irXXB
         7R0NNIpenxM1msz3NVNjgYRVXds5jv+iMAaaUC083kl7sTGpXaIHhAwwnYf1VaG9m9Up
         jh1A==
X-Gm-Message-State: AOJu0YyyqrgbIDua/YNOZ64w0i9cITIZrb2pyEIBipgX7O9uRDX1xswH
	AuHZWZKho9wWKF9312ru6JQ=
X-Google-Smtp-Source: AGHT+IG4ObPwmpstkmv8kV0uDJidVvGSDcM9IXayDvbgBmaMQ9PUxa0v0ATKq9q7QefHzMANhgvTag==
X-Received: by 2002:a17:90b:180d:b0:282:cb42:246b with SMTP id lw13-20020a17090b180d00b00282cb42246bmr2785356pjb.40.1699572526220;
        Thu, 09 Nov 2023 15:28:46 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id 12-20020a17090a1a0c00b00263b9e75aecsm209390pjk.41.2023.11.09.15.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:28:45 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 9 Nov 2023 13:28:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com,
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org,
	bpf@vger.kernel.org, oliver.sang@intel.com
Subject: Re: [PATCH v3 bpf-next 00/11] bpf, cgroup: Add BPF support for
 cgroup1 hierarchy
Message-ID: <ZU1rLOMUJQOGXti5@slm.duckdns.org>
References: <20231029061438.4215-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231029061438.4215-1-laoar.shao@gmail.com>

Hello,

Applied 1-5 to cgroup/for-6.8-bpf. The last patch is updated to use
irqsave/restore. Will post the updated version as a reply to the original
patch.

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-6.8-bpf

Alexei, please feel free to pull from the branch. It's stable and will also
be included as a part of cgroup/for-6.8.

Thanks.

-- 
tejun

