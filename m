Return-Path: <cgroups+bounces-3503-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DB3924816
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 21:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5978DB21802
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC74B1C9ED9;
	Tue,  2 Jul 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD7V8BXA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB87523D;
	Tue,  2 Jul 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719948169; cv=none; b=pcuXrCr8mWpRe5K4t3BkpiT7dvUEFPwggDPcZzMyVE6IAyi6nSApEBsF5/PEZuVMCdu+Qw6Q6GlxoR23wamF14kwQK7XJlaLZsYt/SiuGcbFWVk5Fi+J+K4B/KnkNsZK0DAN4GGJWGTcYuCQ8nz51jm/R6rJPBso2qt8BoSABBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719948169; c=relaxed/simple;
	bh=hnNJ+BlAyUIgMggzWu7mbXvlVyZcRr9ian6v4UfGoHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh8xWWlE8GipiTCbOUtRhCQUgUFabbMyNBuHL8l0KANp36ozqr82crS9c/2WOJ5IzzmhdV4fcLRQlaf5Exp9S7NJTGYjGhSwQfcyXPUAR5iJanZHKBrPJTIGJEXcDZvvGwkBiYt8OX/dgK7Fsp/1PfkMC4QF6aCaIE3SlfojWU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD7V8BXA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1faad409ca7so36931815ad.1;
        Tue, 02 Jul 2024 12:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719948168; x=1720552968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09JInqaD8YnCgkBiCbsziPelZTDmRjw3XZDlsougR6U=;
        b=HD7V8BXAdYydOTGOO4ArVMNUMnXXv5HqbvDFXdNt4XjhRQcILF8SuxkzwRByhkWGRE
         M+2UMjPfEw1GsNoI3ezh53/2ArhyNNx4hqYWKJiGc8q8jqnmm/P1bHj3y3QEPL9Ll5+h
         ehO2fLKfdcrZy1yJeCkc1VjAFeF1aYJmffJUqVwQibVxXt7D8qv50aLNKHncePo+k0SS
         sM/X5zQOiZZ10tHJB51kwxQKAibd7cx0jHuKKl8t5nfohnY2MlgoI1yCFQrrtOHtsAUM
         NAE0srJsfMZIALCnLGm33Ghp59mEXt5UAhnf4bbCnnDnwEUnlKmDNLNdweTmYHsONA8I
         ET9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719948168; x=1720552968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09JInqaD8YnCgkBiCbsziPelZTDmRjw3XZDlsougR6U=;
        b=Oqgjofj/HXtUUmfS+hqHunrZJjR6OzhxIyco8nV2hvU6C6S8Qg1pMdDggRKiLkfpxM
         IkpgJPTYn9cyrP8oL3hzthbGtHIK8ABjs8qJxlTrkqxzU61OuxdSpI08Ul8SoLrDqcra
         JL9mLYozIYQHQau1rG0VQkpPXir9maCBQYPy3V3QN6t2HM7pLL8PTzqYCR/cfx7yeua4
         faigkKY6WbPiV2PlnpOmlxxIXvtdoTkiEZwNfEy8l2EBmoE83juaJOOl0K24j5CvGko8
         HVLEkIaNFHjF8TUMZndD5K9HXdfCY/WAmiHI0+sPuYIOzBzpLBKRck3CLyaPGPP9pJmO
         iiKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnjCooRqwr1LVBObnfWpW5pEW/Dj5cHiKejyLLNBATh4juD8GtU37cn50pcbiIF6J8wVZT/r5ZC1QqYXKe/wYmStNUFbi5YYfxuTUVYYGn3nTfxfV1XAPntHilGkAA6w3D3VxhBg==
X-Gm-Message-State: AOJu0Ywn7zuBLczEsn19Cln7/PPMYcyUB1zKkrc3rIZw3lvE0bjnvDnJ
	o48QpKdYjbXNnde3l5xouGQsX/bLL/YuOdNkfpXDJJrx5y4BQx8b
X-Google-Smtp-Source: AGHT+IGdeUVLcT+EGGmcEVxlgiYWYG8r/9xw2ewIcYsqR/3m2/MzUJZa++NBeRsZCyAPapeQe9GUqw==
X-Received: by 2002:a17:902:d506:b0:1fa:ce44:1cb3 with SMTP id d9443c01a7336-1fadb335c1bmr162096565ad.0.1719948165861;
        Tue, 02 Jul 2024 12:22:45 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10c8f9asm87861175ad.38.2024.07.02.12.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 12:22:45 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 09:22:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Xavier <xavier_qy@163.com>
Cc: longman@redhat.com, mkoutny@suse.com, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH-cpuset v9 0/2] Add Union-Find and use it to optimize
 cpuset
Message-ID: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
References: <ZoMXN3G72xtCLjgp@slm.duckdns.org>
 <20240702105010.253933-1-xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702105010.253933-1-xavier_qy@163.com>

On Tue, Jul 02, 2024 at 06:50:08PM +0800, Xavier wrote:
> Hi Tejun,
> 
> Thank you for thoroughly reviewing the code and pointing out the issues.
> I have made the necessary changes to the code, comments, and documentation
> based on your suggestions.

Looks fine to me. Once Waiman is okay with it, I can carry it through the
cgroup tree. Andrew, any objections? Xavier, it'd really great if you can do
more conversions so that it's not a single use thing.

Thanks.

-- 
tejun

