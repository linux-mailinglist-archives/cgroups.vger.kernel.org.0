Return-Path: <cgroups+bounces-3043-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D521B8D4FFC
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CD4B2124F
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE53C23749;
	Thu, 30 May 2024 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1/gpBVA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296E921350;
	Thu, 30 May 2024 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087298; cv=none; b=WQILxH+2wJAMz6NEELFSpsokFeLuTpd3mymYg+8ZoAJTucjIOAjgGSawo8DE2Myb/qwTeNcwu28hO2zsz7OKDITGrHgG/NRuHlI0r7shNHXxhW2FUDzbtRhfjtbk4wcbuh9+3fEY69tIMy1VoXlvZd7VXTBzQdcVNCaRmKfcpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087298; c=relaxed/simple;
	bh=h+sgsRXRgywtulA6yP05p7p5SlkPSUmpREB4pxqGy0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTzEYScx9zbsdmfoez7m+QHJKEEv0bD5m67qXbz2opqzc7N7gtq/7qRNsjUP707i58RGGOWydF+Qp0lcRAoUNOfWSJgmurm0R9vG8t6cRA9lsfXmndql7ma3CUB3p2gZ+P0fp/GbwLrQs78gT1waw2Q/ps1pZY3tvbeNYmLF0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1/gpBVA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70223dffaf6so1056058b3a.1;
        Thu, 30 May 2024 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717087296; x=1717692096; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7FTH0c3tG+Ht3s1Gg8KhD3HVk6ceCg/0HWZJM2Xej0=;
        b=i1/gpBVAk/HuKoYSgQg/i8TlOwcN5vwamPBLwxpzoQadKdudKaHsLUhWcb1tuoNUWV
         10KZ/dtOBlldYut0AGMdHPju3Nea0HlUnlQkJbZsKPzxopoSSF8RCo3gvJZzV52BpI5Y
         2b/sy/7IHJWmE0KjQDj5T9xecWIYdKYrcAvWs2rQcI4HCEIOXDKRQan7hS+uryMu2XIa
         WK5q4UjSjbl9lcs4RFc+t11HoMxE5SEXDtcfJHBsgh7Ki/3r1Pwn5o4jmR0vAr2oKq93
         whCUCYceQHhgeEaL+gczhcvSgg7ul9VKDVRxQCnr064Bcv0cahFIyijFo9Txiw28Cwks
         X2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087296; x=1717692096;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7FTH0c3tG+Ht3s1Gg8KhD3HVk6ceCg/0HWZJM2Xej0=;
        b=kBK48p8bBbJ98f16IhHxHdUpWU827yQmrwnETGCgo1wDrgwIhrxYubmr0DTCu4JRjs
         I0sstCXkW4cXx5lfmABoqiJbl+RNeW7WH5gH4ZE+ozwIFvVUhcqG0bLJY4Q7TQS8g2XD
         7sikeuhEjZsTMxf1SBzmM53/Veta9RRxDsRlY3mZMyafx5LyJtA1qdQOFvbTjhOwVTkd
         iSEyc8PojIl4oOwC5+j8CR6J75A1D0NzW4lVqMB8bl5VYR6xMQObuYoHGBkgks4SHQ8d
         V+52jQRd7I69sEiCrYb2qASK8CVJdpUhKwzi5G0cVEYXg/jTVkcsi1S5pBEYRp9jQ3O2
         R3rw==
X-Forwarded-Encrypted: i=1; AJvYcCVKaHwoMwl/hONt5pwiRNpeCXSjsX5FcSHave3DEhQzu2fRZo0HAcicrkWj3G0jWDmDY5+WsKkjlBIO3NvSf8/irmQ6Oybw3Qz105rCszY6T8R23gr81CI3GUWChXYoCH5odceZCKPoe0Yaxf+Gpi62mH+0qG9FcRw61CC1eV6AeHtZ
X-Gm-Message-State: AOJu0YxklA1DyZu9/9joH17ff4Sc9vLYL/Ocpk0tVkQoneBwx+m+0RPj
	d6eMjuQSmVHlAaE2bzmMQxzlpb8CTH4xDeoqwD0Gtl3qthTSng+7AEkBzg==
X-Google-Smtp-Source: AGHT+IFEJ//Wt6NvtnyBumLbOBeR6lFNrkSrlEpAyGaWElUnMBNdmB9QqiOM1sO+S3CYJAoG642hyQ==
X-Received: by 2002:a05:6a00:2d81:b0:702:3b69:9e6e with SMTP id d2e1a72fcca58-7023b6a0c7cmr1352847b3a.14.1717087296127;
        Thu, 30 May 2024 09:41:36 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7022a5c2cc8sm2100730b3a.108.2024.05.30.09.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:41:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 30 May 2024 06:41:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>, Justin Forbes <jforbes@redhat.com>
Subject: Re: [PATCH] blk-throttle: Fix incorrect display of io.max
Message-ID: <ZlisPiR1CGLRq6PT@slm.duckdns.org>
References: <20240530134547.970075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530134547.970075-1-longman@redhat.com>

On Thu, May 30, 2024 at 09:45:47AM -0400, Waiman Long wrote:
> Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> attempts to revert the code change introduced by commit cd5ab1b0fcb4
> ("blk-throttle: add .low interface").  However, it leaves behind the
> bps_conf[] and iops_conf[] fields in the throtl_grp structure which
> aren't set anywhere in the new blk-throttle.c code but are still being
> used by tg_prfill_limit() to display the limits in io.max. Now io.max
> always displays the following values if a block queue is used:
> 
> 	<m>:<n> rbps=0 wbps=0 riops=0 wiops=0
> 
> Fix this problem by removing bps_conf[] and iops_conf[] and use bps[]
> and iops[] instead to complete the revert.
> 
> Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> Reported-by: Justin Forbes <jforbes@redhat.com>
> Closes: https://github.com/containers/podman/issues/22701#issuecomment-2120627789
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

