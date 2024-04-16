Return-Path: <cgroups+bounces-2546-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C388A76DD
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 23:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9FB281D36
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466313AA40;
	Tue, 16 Apr 2024 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUaIWbfJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D1C13A3E5;
	Tue, 16 Apr 2024 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713303384; cv=none; b=YxJ6TzUYg/rm+7NkeLGzCSazud2keY1tceKAP6eGwqv/lQW/37yfq4kY4y7SXDHv6LUf0OCD4wwIKiX1FazGAepfKUE+KLzW1/kf6wrSAnFR/UuwnHqGZJSeESNifn8zJ8HerMAQDLsaKuDHpW3XNtlkfnBQ7aBOubpMQ5bOhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713303384; c=relaxed/simple;
	bh=hTZj3zFH/capdeqXw5vQK5e7OMPUwsVvEofrRIwsyJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBCgIf0uTd8wbjEa6A8LMj+a00Apb+O/SBuuN7uTqkdJ7IUTEy/c7YCgfAgGsZoWXuN4fSWkfOto74Fpxlo2BnzIulQ0ykI8H+GQQcBWjMbJK+l8GGgPi5Pqgmwify2rpNCpBr3fa2dr1CysHc3nje5iAUzK0yDjb5mxm+JbcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUaIWbfJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ead4093f85so4108137b3a.3;
        Tue, 16 Apr 2024 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713303382; x=1713908182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNYKjlq69Ck2YSCS4K7cKN7J0KiR/K/BwPBXXkuJ58E=;
        b=lUaIWbfJH791Rxg/+cUVzv0avclvpqLTrGPnhQRbVDrM3CymmZv0QLFh8D0/LUEI7T
         J61XgqoD7yNDODyJZ8eipOT+S5tnAUT5y24xjk/waWmIhfOjkIKwWjQIIGwbN1Q9Uszp
         8iWRplvFbpovDVGNx+5eFP6RZMA7X17pTMFeaMqcHju1D+9fzig6aVRwOXUnY8ZlDfH/
         W81ZJ101nWmF4yxQPTWZtMVY6nqlt36rURiMlAuaqHcqLdJwZYJS6zY6zIZdw6lcJMio
         KQvYwvBN3jqoaVs2dfAOjukt/mNN8G1oScZoHr7HxoNM2A9eBeX3EDpFoqi+V5/Lf2ap
         tm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713303382; x=1713908182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNYKjlq69Ck2YSCS4K7cKN7J0KiR/K/BwPBXXkuJ58E=;
        b=jOSePsQdALPF2fv7UldV2vistBo9PCPdk9PXbDhlKU/kAXi+cvKo2MYPwHW4kH31QY
         ADIslsZ39HJi+XkvJw4JmtifSs3N6px/tcCkYds9y9B+zihYzizrsbkwkbe0IjAChd1j
         zGT8lLZ33SgMFBiNuf2YKOVHG2f7JDfyqFJofYW4uOXDFI65sPCYLXghmYbfXbF4o/U2
         M5YsJHkE8401kIzUr3ScjjRK64KidZ8EO0N0iQomu42K7h+Doc3aobr8Be+LhLbfE6FG
         2l8qU2YkoxMmESgQ+W36/owYcdfnhaSowvIImpxh4C23cDCULnCTj2DPu8VSa1P0uC8v
         3YcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVww9RckeQ94RfYd7nGaGw1AbsyAiuP7R+3xFg65BdKD0uBq7XYy2Vd6YfRcStunYNYnOBDHE+X5vh52zA9M9KQeIHEWGbFIoK1DJ+RxN408M1ch9bH36YgmuzAsz+EWKDxyRt+Ihq8ZBSXTm/kFTYXbCfeAe46T+rPSaKKw==
X-Gm-Message-State: AOJu0YzPs0/5mne/q4Ogs36xUWSHzMwiaMWfMQ3GYFXVyxFBcAk/esUq
	WwRAQlX0Y4ph47HF2Mv1PU0JjRMtjaxnkBcD3IQdMi6GTupRi0fr
X-Google-Smtp-Source: AGHT+IFtvPB3hU1q5HQQPGVksw0oSgLO5/7Sm0T/QIFSiT1oaA+hQ2aTrUGjHmH0e6uOCRrKzFmQQA==
X-Received: by 2002:a05:6300:8084:b0:1a9:5a2a:7e51 with SMTP id ap4-20020a056300808400b001a95a2a7e51mr12935570pzc.24.1713303382256;
        Tue, 16 Apr 2024 14:36:22 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm9400413pfm.25.2024.04.16.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 14:36:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 11:36:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, cgroups@vger.kernel.org,
	yosryahmed@google.com, longman@redhat.com, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	shakeel.butt@linux.dev, kernel-team@cloudflare.com,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	mhocko@kernel.org
Subject: Re: [PATCH v1 1/3] cgroup/rstat: add cgroup_rstat_lock helpers and
 tracepoints
Message-ID: <Zh7vVPp-Rj5hB6eN@slm.duckdns.org>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328988660.3930751.17537768209042139758.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171328988660.3930751.17537768209042139758.stgit@firesoul>

On Tue, Apr 16, 2024 at 07:51:26PM +0200, Jesper Dangaard Brouer wrote:
> This commit enhances the ability to troubleshoot the global
> cgroup_rstat_lock by introducing wrapper helper functions for the lock
> along with associated tracepoints.

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

