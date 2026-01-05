Return-Path: <cgroups+bounces-12926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53555CF5BCE
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 22:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35E82300E4EE
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 21:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62D311C07;
	Mon,  5 Jan 2026 21:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UaRdobbo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D883115A2
	for <cgroups@vger.kernel.org>; Mon,  5 Jan 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767650240; cv=none; b=Kgs/0P9qnhai5kEP/yyR9rLvs5t6zXYap6kRSh5LMjrOcTizejOa7LaBtfDDkXahshPpQqN07cTfoLbKznSdBXB+LIMSrvrGvy9Q+kMbJFKY+JI0S2mT6IdxQOT7IDHKRhT3F4cqi28yq4wpZl2dtneE71EVzonokUpH3GzMfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767650240; c=relaxed/simple;
	bh=ruUH3riTuQHbYhQB8sTumfaclO2ukit4bkjAu1GwEGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULqh+qv/LThFKND+/6I1SN0X7mUY3SQQNhnKiQIKvXtcBdXqRXa9ME7EjEHb2EmcL1X+7nnEotQx8X4WPJtJqwHQKkH39KL+OFjwsLoEQLmLkHy920kN2YUhEOBVRjlbjwKC6QHiNSD5ZwYM5HsFDlC7AquKtLKZzSLqirD5N44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UaRdobbo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a35ae38bdfso18785ad.1
        for <cgroups@vger.kernel.org>; Mon, 05 Jan 2026 13:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767650238; x=1768255038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruUH3riTuQHbYhQB8sTumfaclO2ukit4bkjAu1GwEGg=;
        b=UaRdobboNv5fK4FUY2ZS/gU/M8GSmA1eAOb1lMmFbFYNDL/sJgnx2kzmiNzRBPv9tY
         eTpN8fzTtCql72MO6PqH9ofDAB7Et0Vm9Ki/nK5HKFjbQNxTesHmm5PI/QL7loODsVZg
         BfHMywGJTpB3cRxILBaso97YtrG+IbDaRulHl4geMy5Xdjw7J61J1kGCf7jl0zRKZyg1
         iMKqvX5pZq+Bco1twvCpV3KSH5EHyX46+i1+OICQws8P+dHeeDHeu3CaVcPMX3hD3Wfz
         p9xZLIHcP0FDt+jKsICD0EkGBHW+ZKd9w8Bokd2V+T7x4Nt79xv+2yNTMnUjxIz4v1pw
         FG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767650238; x=1768255038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruUH3riTuQHbYhQB8sTumfaclO2ukit4bkjAu1GwEGg=;
        b=FRp8Kq5j7LqU9w4IZ26iEdqe7ozC4mnqvCfrjtjDR2BRdKOzx5peSh4gKrFIhgqQRq
         Msj27yer4HrbP16Wchonsj2hF/rO66XGUghat1znj1W4QmvEzNboF6wCGrry/bg5lUGN
         wqhNbnm6DIiPwaruxn31oCFHmjJCgximEULUad9An6OGGyau9qASFx844tW37u/wuy4q
         J/0W0icXwJOA7FAEwjys/SNEnKtQaL2jtDcLBwB2HHvmxPSwXM7Huj17e+mdC2n4KNmC
         gxFii2R0qcJ31FDqotGcxgM5dkl+pPQOZdvm47AvXZWB2UJGIZG61ESS3K6bAPVq7yLm
         eh/w==
X-Forwarded-Encrypted: i=1; AJvYcCXv+s93jANf6pLxrbSXFLoTqYb1UpYXz03s4wA9PZggs1UiRbKXo3toykxAnUQL7dCV1XCO5mHt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx62uA6oVGB+etckv/GMW/smYiBFstPcCI0esMm6j78Qrm7LiCS
	8x+moXxcKfeZg+5ANE08GYaVF+oa9sSv4o6uV+aiWoFOgyK0JHz5yuuJjEoC0Zmpwg==
X-Gm-Gg: AY/fxX6x3wWg2VNQp/1ybU/tDBIcKBo/upMHMupMM7OV3srx8EvDCVQStyxroB9IwRX
	XiwyqhyOZi/XQe35NCQLHm5ah5PW0UqqIjK553ak2A4srYXBGcNmJ1OOkndaey13kEGVoPQK5Ap
	jZIaRhHJ8MxCWHaGcY0sDByQlhYR9QcJnVYe+2chaka/5/5JPBF/C2jV9ORN8OvLpiMGY9f90IL
	1QNb/0fi4I7IbZxpltjwHsCdtkrbaARswhDRiEX67AwYUG7EanQRtfmH0LuQziqoO7qVy7OTNiS
	QAg9P13j5imevt5XiEzjDaoVg+Tgo0tBhYw/ftWsaAwlSuzQk6CBnzeVtopZ4btEFvNWtUc3SVH
	lF/50KqugfhH5eum2kOR/q9kz/sea/6RKYW8LA0hpck9sHBzgy5Bl4Xdi2KlRy+r/tQnUxIXa8B
	OlyRMYWppRUu8o41ecyPqSerDVaJvOSwELXFHxc/Eda/MNDmP+6xFi
X-Google-Smtp-Source: AGHT+IHtbE40ji1Wx3VGfpDxGTUC9DPehcLKlVLsl+ThRkRZLTI4SG2xNYa3tPRCrCOLKGLV8YRl5w==
X-Received: by 2002:a17:902:dac3:b0:29f:2563:7772 with SMTP id d9443c01a7336-2a3e39a3a2amr703455ad.8.1767650237230;
        Mon, 05 Jan 2026 13:57:17 -0800 (PST)
Received: from google.com (248.132.125.34.bc.googleusercontent.com. [34.125.132.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c52f8e10sm112198b3a.44.2026.01.05.13.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:57:16 -0800 (PST)
Date: Mon, 5 Jan 2026 21:57:11 +0000
From: Bing Jiao <bingjiao@google.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, longman@redhat.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com,
	david@kernel.org, zhengqi.arch@bytedance.com,
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com,
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
Message-ID: <aVwzt9oFHgjSFUi3@google.com>
References: <20251221233635.3761887-1-bingjiao@google.com>
 <20251223212032.665731-1-bingjiao@google.com>
 <aUs_pLTcsVK8zf0g@gourry-fedora-PF4VCD3F>
 <aU7YSXnoBTFRy-KF@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aU7YSXnoBTFRy-KF@google.com>

On Fri, Dec 26, 2025 at 06:48:20PM +0000, Bing Jiao wrote:
> On Tue, Dec 23, 2025 at 08:19:32PM -0500, Gregory Price wrote:
> > Have you run this through klp?
>
> I have not run it through klp. Will do it then.
>
> Thanks,
> Bing

Hi Gregory,

I tried to build a klp against kernel v6.16, but it ran into a
segfault during `create-diff-object` using kpatch-build v0.9.11.

I do not think it was caused by this patch. But I will try it
again at a later time.

Best,
Bing

