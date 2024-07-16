Return-Path: <cgroups+bounces-3715-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBE99332B8
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 22:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29BC81C22854
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762E71A08BE;
	Tue, 16 Jul 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCa2hcXd"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740D1A08BB;
	Tue, 16 Jul 2024 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721160728; cv=none; b=I4lXxZkNd3msKj7WxSAt7OxTFTT9cJvesQd25cNEN9bJqD5GMoDscVLL09fX+eBNZqK/DR1hLcidyjSALYpaT37rLbdJOoTs12eP4Xrml5wO21c4/xGtSau1S0EmCDSSkWRhJnbJ7IYJk1YeW29YEgSVgUFodjA2OfYp4//A2MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721160728; c=relaxed/simple;
	bh=8i+xenZ6D+Nhq+d8YXvmWzsEvf8PaAiQ8YBh/ZlbcVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeRZuauTmhyFxPYbFxIVlzCIaBjFAUfJQDQHejiMdde8OFRbweZxdM4sbOBzogIhUrPSg1h7sDiX1YGGzpbmRW61dfRCPq64FiBIHZz4EffSEDJj/ht5SOT8MuyH7ly620wbqVyTSw5y5SZQW6x8WQjrOo6/y8hBIWVyWYOo2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCa2hcXd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb1c69e936so33472725ad.3;
        Tue, 16 Jul 2024 13:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721160726; x=1721765526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlTyfm1/jbIYhBi2yrrQIo4CESDXS0z+TL86f8EeJbQ=;
        b=PCa2hcXdTc0HQ+CDSWwKcSzw4dLj5CorCaSOEbkKHTk7qkPh2msOyGxav6otX2h4EY
         F/1mI4U/HWfnZCWjlqREPyoeDckscUPCOPNYvoZB75aAEA6JxsZVdJE/pUHoZWJkw/+7
         PAU9c1ZpmywYtIuKnuPbT6nssoOYHgOHUt3l0OVssFhtB7Wdq2bu981ykjvjxHjjeoZF
         Q7LmTPiIKxBYpgvWi7cQ36Hqz7WESdsgAc+JD+8VzaNM4ZTjYJCJ0S2P+mzu40kGtY6E
         kpHi36a1dTZp5rkC18WGXf1Qq7ktITX09thW3wlrySNRL2B2yzDm57mph3jyrYgMpSzK
         9YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721160726; x=1721765526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlTyfm1/jbIYhBi2yrrQIo4CESDXS0z+TL86f8EeJbQ=;
        b=apnehST9EqDwOsp1y2JvO9D92TIuVOSMZRTefodtvPb9FtCYKXO07jGf+N8DI2DXUE
         6EJDzwJBdQFfHYEDF5OjkDAPD99JD3Y2Dc9e7okYxUJCpfAuL1H3KLGXkWuiff79EeTU
         KOYVWC91N4CFIDnruunMoG/8LZiHQfq6z9GZo4HFmfpqoiyNMAVnypmzK+b/BZig2WFM
         PDjrVPsHlCtLJ/gOh/jqORFx9cB+gcOQgLhzIQRBaxwp12ZZ+4hLr8idQU13I21F6lFu
         FmnEkSSgueb+cFaIEqvfiUM3Q/V20wknklgssY2NIvdc66ZHsp3xGhtEllY5TJgjaQ9C
         1zcA==
X-Forwarded-Encrypted: i=1; AJvYcCXGb0mpIwt+AHw6lr00E/SIKy8sgx5/yIj3FcelkVwrYayaIwQ2V2npsgXlbPisQW3iYM4x873KR4NmSe5SaQJ3IMdoK11cmmxO4QJZJq2uBr6QEvxgr4WwQCAffjM935T47ZMLVunU9y/lD7c1XRKVmsKjbMD4GeT0YnugxqZPf7hy
X-Gm-Message-State: AOJu0YwgUhdHrZuZcg0wIUjaCKma5s/5s3yPFrbVW6Qw/2kB8J/8CphJ
	4yJGmPoZNIWJwffEwSkvo5m0tl1GemmYiWpM0xHk9NtmbDWkRQmp
X-Google-Smtp-Source: AGHT+IGyPQVB25mxI2bZvFvTBBskLBjCYGwvrV/m9+G+S0nNa5G9734Iaw/DiNbm/Vw6oSvWmCBqog==
X-Received: by 2002:a17:903:1105:b0:1fa:fbe1:284e with SMTP id d9443c01a7336-1fc3d822fe9mr30385695ad.0.1721160725509;
        Tue, 16 Jul 2024 13:12:05 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc263c5sm62536995ad.174.2024.07.16.13.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 13:12:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 10:12:03 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] blk-cgroup: move congestion_count to struct
 blkcg
Message-ID: <ZpbUE3L4Xd0R9-SU@slm.duckdns.org>
References: <20240716133058.3491350-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716133058.3491350-1-xiujianfeng@huawei.com>

On Tue, Jul 16, 2024 at 01:30:58PM +0000, Xiu Jianfeng wrote:
> The congestion_count was introduced into the struct cgroup by
> commit d09d8df3a294 ("blkcg: add generic throttling mechanism"),
> but since it is closely related to the blkio subsys, it is not
> appropriate to put it in the struct cgroup, so let's move it to
> struct blkcg. There should be no functional changes because blkcg
> is per cgroup.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

