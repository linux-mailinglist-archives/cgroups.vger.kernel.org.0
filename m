Return-Path: <cgroups+bounces-3668-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093339306C1
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 19:41:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B888C282403
	for <lists+cgroups@lfdr.de>; Sat, 13 Jul 2024 17:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556513D279;
	Sat, 13 Jul 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjWQWGxL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34922097;
	Sat, 13 Jul 2024 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720892474; cv=none; b=J2E+Y95DFJf2/HxTICgz743t56ckPCmYg1VNMOlCMGC6ZUhS7fl79FEZiPUqdaiojge1vP27HwdkvpI2RFGfnM+SG4zzlY76lfNxCIdEmVJCF4IwDv6DdlnOxWX6QUf8CElWk8ngBKjrv6z/xX5VTIaBvSQFl2WcdoEgc3qxTk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720892474; c=relaxed/simple;
	bh=b6IwdgsyE74wgFNTy+MtOWlStYEM4TivbuAuG0fjkts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxCTeHXROUWFg7iRNjbAVp/himMarxZsQZD8rw3ReD2VQXaW0p5kHLCKI5wAlxb905oLtJiVXaBFnDZ2ZZn6bbkktHZZ6mnRfZkd+L0nFxxX6xIBJk2RQEHBzGIzBBklw6v/JbIZS0PKC9NdSDsOr+QADWksVQLB5NXBIZjwYkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjWQWGxL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fbda48631cso22819225ad.0;
        Sat, 13 Jul 2024 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720892472; x=1721497272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNGgB9IVYFVqdTky30igZrAZORz39IUvtVp065c+ZLg=;
        b=KjWQWGxLb6RBKs2QRhKJdziztN2H8UZzo2Jj2lcEueVJk+4oKPlxOjaLo9uJKg2ZH6
         hJPsWl+YXoo/kQtD3sM+O6lublcCdGMXqb4na/PwvfqZq5hkJj3d/+q8MdGO2z/+dzTj
         QIS6NC5TiX1CkLzDg4+8sOQCI+7Qu5SJxcCQd5B7JGIHHpDw8tJxEFoZNs1wDoqXkh7a
         nuCowT1TskFylW3Zkaez1E9/Dnd733PGSKJoIhVrfdX6mqHf9C+Gz/f6GRijBrxokbdk
         puLWzBABe0BqIhpgCixxa8V+4b2BOZee/RE4OpEzaDAjAyNEnsem1swuJcSC7lmiQiH4
         JAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720892472; x=1721497272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNGgB9IVYFVqdTky30igZrAZORz39IUvtVp065c+ZLg=;
        b=CIwLsJZoPnvThddhsPvvYEw7qj64r24sW48MLbrassZHYi5qo1WyukfPk1l+Gpx0xk
         t9LacWETGSmr57ECNQ2L+M9yw8vA7NdXB8Eoumn13nJ+/i786HKoEh9myoh2U6ifsT6D
         LnG8CrBzjy/xCdVF/HKFc4FdCpyPrm5jOh0KAOqFCM7hpzydErxwI/h2f/FSOCujYgR4
         2heyfHjYS7Z5RJCE+kMpv8Z+uUIRk5lNpTdkyE/RG/+tC70NdoOVbJq5hB87Kt2IcROU
         ydWrOk7wOKw7BhXfPcH9koYcVB09O1gvizg4XYxLIVD93CqGANVHBqqs2ivma9prBhwR
         n38Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhNfOsBViR3jHdtn29IUVfTKiqz12na9t/ZBmU6afB+kHBUBlbLSnu2YrKeaJPPF1cWKb2CsmjhiPziTSkjt+c3D+uVTdz4RMtFNzgjTZsRWHnx5IzE8R4zJKRxHEC8yiLmvW5CGvJophKuLYi0GJ5ZMbAEafGzaRt0TJeuWUaFGN7
X-Gm-Message-State: AOJu0YyIIK1qpZMxyRYAaxGK63HHPJfUHOvHeJei05qlLP2KOVu9IzEj
	Vm+Zgq/R0LNMclcFVg4BVOuG9okC9Aq+FXw062qMGMRmxHESgQlLJqeoYA==
X-Google-Smtp-Source: AGHT+IErTCb6aICy06TRFg73JH57oLVIl8Yzrb4aqgvN8a3Wxp00KNYo0dH06fweZYGtm5Mod7RF5Q==
X-Received: by 2002:a17:902:684b:b0:1fb:5f9c:a86c with SMTP id d9443c01a7336-1fc0b4b3c89mr20942825ad.3.1720892472138;
        Sat, 13 Jul 2024 10:41:12 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb74d99sm12752225ad.8.2024.07.13.10.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 10:41:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 13 Jul 2024 07:41:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
Message-ID: <ZpK8Nup6_sOvSZ7E@slm.duckdns.org>
References: <20240712085141.3288708-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712085141.3288708-1-xiujianfeng@huawei.com>

Hello,

Sorry about the previous reply. I completely misread the patch.

On Fri, Jul 12, 2024 at 08:51:41AM +0000, Xiu Jianfeng wrote:
...
> only compiling tested

It'd be better if there's a bit more verification.

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 37e6cc91d576..01d3408c2fc6 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2183,11 +2183,13 @@ void blk_cgroup_bio_start(struct bio *bio)
>  bool blk_cgroup_congested(void)
>  {
>  	struct cgroup_subsys_state *css;
> +	struct blkcg *blkcg;

It'd be better to define this within the loop.

>  	bool ret = false;
>  
>  	rcu_read_lock();
>  	for (css = blkcg_css(); css; css = css->parent) {

Also, if we're now dealing with blkcg's, there's no reason to go blkcg ->
css -> blkcg again. It'd be better to get the initial blkcg and then walk up
using blkcg_parent().

> @@ -95,6 +95,8 @@ struct blkcg {
>  	struct cgroup_subsys_state	css;
>  	spinlock_t			lock;
>  	refcount_t			online_pin;
> +	/* If there is block congestion on this cgroup. */
> +	atomic_t congestion_count;

Can you please match the indentation?

Thanks.

-- 
tejun

