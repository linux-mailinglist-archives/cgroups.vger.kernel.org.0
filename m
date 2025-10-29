Return-Path: <cgroups+bounces-11319-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D57C18CEB
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 08:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6984606A3
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80FB30F959;
	Wed, 29 Oct 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V014Fm/0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9930F953
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724434; cv=none; b=O5arqZvKUY2u1ErVbgiMyu6Zqe/zzgTU+VaD4T1QAwx8zwBAzdWvfJftTXEC9UK1UT8QWb9Rh1oq4ujx3TvpvZxQGDpWm6bW1DSqnablBu7MkfXbRqnpUe20XxR4TU6gMzZH+lrPMcilN8FvE5CEZbc7ssPH25seyWYKQbhd6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724434; c=relaxed/simple;
	bh=9sBqHtMzkgHNQvGNmaU6cyr7BjLPfntGjyHDzqjj1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVx5GmeIQ3FnOXRS96FR+ElDjiiYgTvx8Wqp7Uva1ckI7jbjgAkN31IUOqL25Gi4HitCU/pZIaGMi4ERNEwJWIJ6qj1sm7FaPZoy2DuWren0QADYr6BLRHv7XDXnDT0xKNQFZVeGk1z8B0ReFfA9F6DVyX4ozZSsTcpNwmwRGrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V014Fm/0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-427007b1fe5so5748012f8f.1
        for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761724431; x=1762329231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=swQK60xfML17J80u6tuXniIURK0iR+v6N89D6/+kOL8=;
        b=V014Fm/08zxPpn2lnh71iGn9yRnXk3VNrVPUMNjoZwlY/YWv+3rA6vLTv607oEFt40
         KQNqS+sAGlIfOLG8PTJGxb/NFgP2XKPR7VRVFvBI9Lk4JXlxcQVNRlOAiUxC4ua3YoGc
         w/TZuTN++48ehToSjt5EUhpTMG6uUg9xnatQBkpWpI0OqTdESilNfwJu5lGl2bcT+HGr
         NlgbE3F2t0N+I1K7XKpcmkyz5lOaQWwxs7Qu9SIx1JBVhcyP+LnG0vKcUY592yMG59Do
         hK7OtxeQiDDe8/hhMw+e1gb3Cn4yRS8ghcrGorvxn4TmS7P7isQ6lChD8grIp6N9qsDB
         7fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761724431; x=1762329231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swQK60xfML17J80u6tuXniIURK0iR+v6N89D6/+kOL8=;
        b=jsE5IB3emipq7RMM7M/Q8Zwjefd73wooslBiDOxKymGzmHZKcPvvro8RRWFsWODkdY
         1M8apg4FB4fKdhiqzFdtF5FPEkabgodV521aNgPYdF4k2GUd90Vt5corbFKGpj9vB+bc
         Hvg69OseldfY92QPzH59JcIfEEqE7XwgcOn8k5JyyVDe06qPsIQJimHfckeDjW7gUXt5
         7HALUcj/nXvfOaBqhcUYWGLq0Q652Ym8yqAaGJJuW3B+cZqNzA704NlZzdxKJpxI/fgK
         dvH/tKPF5Y47+NoEOpyNhISjtV1twg1jhWU6wugjTP0sheBn6LVnNIj8XNXip1LXZxdq
         89UA==
X-Forwarded-Encrypted: i=1; AJvYcCXhgRMibk/LB5nvY2/lRmLgrghKFPM08zTXsAqa53F3JJ1WWWgmL2cWmAF08ObVg/2Mp/sRBRNA@vger.kernel.org
X-Gm-Message-State: AOJu0YxGduj5099+mAIdd4on3Jxq4FivLIBTBfYFeD1kKTxfkQ4+jjQL
	JNTccfcbjNio1lVb5+DFPIUA3kJWGDzm0wmcJ0dNzqhUayGQobbTS35Irwg5/yHTWA0=
X-Gm-Gg: ASbGncvUrtTjPGgZzi94EvnhzSP/eR+Q1AP1ufOikHBnuW94TOO9vxDQa+NR6d91+nQ
	bhBU9MKqLuK3OLbmH5NXeQJyL7qaC25NoEhbxGjkFBkOyS+0u81RmCOnYl5ehMgu+Rub+w+XRaz
	MbshQmLhoradYWySv1BRLLde17yJrFWLdX5ZSffR7STjCiJ1hsEfqS5++SECvN97HIkJFc8Sb+K
	k6P5xp8Mlurquf5PJYa6MjHidI8wXsWBUlBlAwHBJLUMsCf28dH8GjbMuYEza6m9SiFTVLAEWCH
	EjAjaUYL9mLpr5ncTGHwwwm318CQDV6c8mmERLnZio4pdfdU4YhobAQaLGfJG9J61e+GAhcy/rz
	sHNsUk2ojA+UAsZOEoyGoFTdGk4sZdnyw8qiWKZoYk14R16w40syaH5orym26HoTed04ceE62LW
	gPhFaCb1tZOvYMkg==
X-Google-Smtp-Source: AGHT+IHZNv776MNAkq85ErWoiCefggPtR3LZHBTitBCxq6kWhcvpDiu2NWRGcgIae8q/Y/YRXY63yQ==
X-Received: by 2002:a05:6000:288f:b0:429:8d46:fc58 with SMTP id ffacd0b85a97d-429aefd2c2cmr1389158f8f.60.1761724431036;
        Wed, 29 Oct 2025 00:53:51 -0700 (PDT)
Received: from localhost (109-81-31-109.rct.o2.cz. [109.81.31.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b2dsm24452114f8f.2.2025.10.29.00.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 00:53:50 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:53:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 00/26] Eliminate Dying Memory Cgroup
Message-ID: <aQHIDWDx3puT5XZd@tiehlicka>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>

On Tue 28-10-25 21:58:13, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Hi all,
> 
> This series aims to eliminate the problem of dying memory cgroup. It completes
> the adaptation to the MGLRU scenarios based on the Muchun Song's patchset[1].

I high level summary and main design decisions should be describe in the
cover letter.

Thanks!
-- 
Michal Hocko
SUSE Labs

