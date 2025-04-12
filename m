Return-Path: <cgroups+bounces-7494-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA43A86990
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 02:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 348F11BA4EAA
	for <lists+cgroups@lfdr.de>; Sat, 12 Apr 2025 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B128FF;
	Sat, 12 Apr 2025 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="q8dn+w3r"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A156F10F9
	for <cgroups@vger.kernel.org>; Sat, 12 Apr 2025 00:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744416601; cv=none; b=HU4hIqbWrnKqGBz+bZavXrDZTViLM6OYF4e1wli1tpmLmrE7UnCYJjAtWuwEZJFkYvSImPZxunEnti5XuRBmbpENlU5i4tc1OYzSY+eYKJUJxfvrEdf7fIFCxeXqVixIo/1foWFOcWnSBqxtb/18yLfUnJewdZxKJHG1VFIeysk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744416601; c=relaxed/simple;
	bh=4udWdYCIO3StV4kFbFRa++0FQ68vJBjSV6UL63Sa9AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY8UchNs7IDkOQ4pmZptjCOr5W3vyS3gJvmW14lv4NCBfMoH4vo+jlslezqm+fV8G103y042AHv0DvDLIZN2pTiue67/dvOvJAyLZNY366NaQjoO2wLNeqrgJw8B7UtDUurOIqVUh/9dmm6ePF5wy3Rd3mf5cj5qAR5Z/xZxfCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=q8dn+w3r; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c07cd527e4so244658785a.3
        for <cgroups@vger.kernel.org>; Fri, 11 Apr 2025 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744416598; x=1745021398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sRXqNVmIqyS+Jz6z2updy3JXW7i0nvOqZaWjs39Mac4=;
        b=q8dn+w3r2aC4EjheikU6hx+QO7voPorqo0YWgubvdfdq2n4foJVUQqdTvNak7HMuq8
         wxx5q2rBn4bGbB6yb3LJ+wpUIO6FA6uvnUiDbgP2SJwzBvB63SJnBIpglfJH9wkZJvAN
         qgx0/u/p0LUC7P/entv2ZGNNH9pi0Ly6vTXVNbH6aeqBbJP7dgyTgON26Nfprb+rMQaa
         h3eg/zrYFEjmt88hwkot2hXJp+R+gGs6/40fMXjth1V/PHYQ9S2su4ha+AdeB9rYea2F
         HfhYDNdFzsHxGd+qEluKcLautgEZGE6a9ksw88iepGkIHxc4ZHjhX9Ppp300YnOKpwbV
         nxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744416598; x=1745021398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRXqNVmIqyS+Jz6z2updy3JXW7i0nvOqZaWjs39Mac4=;
        b=ZmthAMBlZwqjJoeQIQibf+gcCrC9kOOzfhiMkPBXwhYkO01HILpY6+S33+kk/3C/M+
         9xzJEzT34rFeczFO+Origzh8SlIMm2rZ0GY/lNcPLbvKDHdZehiNYYh0EgvR/jbAovFM
         naxD55jD1TEb77UQ2zACyvXx1hhp8kn8goktV6BX5P3aiHu6N6p6oWireJSI0o3BXnCh
         okFc5csfamr7KQH/VjYWT8a+as7o5Rjoo55+E/IBT1STW54OVkICDep+GaLBUBGzvcyP
         Wk11eFd93Ko1TjfHsm7tXEBNrML9Hur4gmHDBCpsMZOLSvIX/EqsbAvyqH533jGESFRT
         M4CA==
X-Forwarded-Encrypted: i=1; AJvYcCXewwhje/bcWM0izjIMTBK9mjdmqkDr6PeJiUxFoJFqUSFBIT7zkqhrOU5PPlSK2d0+XNP/dPb3@vger.kernel.org
X-Gm-Message-State: AOJu0YyfwVggAC35S7D7LSj140yRgEtAeSD/9M13gw6j0QnRqOgER/61
	zHIL5yIi074X3A5FQuJeYATJ8iTkrXjGG7GRiuATIftS1pk35V755s/NETkvqeg=
X-Gm-Gg: ASbGncslYSZYozS/ujcX4oZNxbOKUp3tSuui6Rou2N+Urzog/8B5U/vvQi/7kCYD8q+
	BcIE/Hrk8eDVrxOgCF8X1jG/s/nvq68ppORFLgzZdMV+xoYZnjiNq4OBtq0JXMemkwTtu2Zusog
	PQLGL+8SaUKAKUqlXShisksCH95m1HWydNM+vTt3sP3q+J+1qsWt2Ef/NfTXs3uJ4jmQgyKNX+C
	oYOEsoRZnxQrngH6GKUblIR7a+M2E3qgm+BPbZSW/ab94n3FvWctW2uH5hWLBzE6pJYYQ/rbgIn
	4W0sjdWfuIeAUaQPNfBdXYYn0kpuyY6c/XytTsMBcFCJq/bz8TJy365yY81Hho/wqYXQMGdREZG
	kcJ51vLG22VaQj1D0s0ZG2AVMuCorIC7hEw==
X-Google-Smtp-Source: AGHT+IE5Xlwy4jufzqg2VNoz64xedL1xgIf+lmQN007iCJsS30QUHvJ5IGhsqxtG1KRey8ZizqlU6w==
X-Received: by 2002:a05:620a:468a:b0:7c0:be39:1a34 with SMTP id af79cd13be357-7c7af12dde8mr794060785a.43.1744416598362;
        Fri, 11 Apr 2025 17:09:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0e6ddsm329175385a.107.2025.04.11.17.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 17:09:57 -0700 (PDT)
Date: Fri, 11 Apr 2025 20:09:55 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
	shakeel.butt@linux.dev, donettom@linux.ibm.com,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Keith Busch <kbusch@meta.com>, Feng Tang <feng.tang@intel.com>,
	Neha Gholkar <nehagholkar@meta.com>
Subject: Re: [RFC PATCH v4 0/6] Promotion of Unmapped Page Cache Folios.
Message-ID: <Z_mvUzIWvCOLoTmX@gourry-fedora-PF4VCD3F>
References: <20250411221111.493193-1-gourry@gourry.net>
 <Z_mqfpfs--Ak8giA@casper.infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_mqfpfs--Ak8giA@casper.infradead.org>

On Sat, Apr 12, 2025 at 12:49:18AM +0100, Matthew Wilcox wrote:
> On Fri, Apr 11, 2025 at 06:11:05PM -0400, Gregory Price wrote:
> > Unmapped page cache pages can be demoted to low-tier memory, but
> 
> No.  Page cache should never be demoted to low-tier memory.
> NACK this patchset.

This wasn't a statement of approval page cache being on lower tiers,
it's a statement of fact.  Enabling demotion causes this issue.

~Gregory

