Return-Path: <cgroups+bounces-2534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF58E8A71F4
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCA828475B
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2A4131BD3;
	Tue, 16 Apr 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wqy9Q+bD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCC10A22;
	Tue, 16 Apr 2024 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287371; cv=none; b=q0RPQ8QQ96eMzWLQk4SllFlIeE+ozxdTdrIZyTVBR44qbgusaRidMju2YoOhnjn3foHGpo+tmBWVx/oruy0Sk1Cepn9W5QuR7CwTxEc6Fu5ro/5ZKOZUVmjHnzG/yGY5RQ5xWzXlY4JnFAx7beSh8ajPSTUFPUKvsGAEvtOZY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287371; c=relaxed/simple;
	bh=DUpZQcj0Q4Y4tjm4OpJ+gbfAVkEDRRSpm1tH1KPWzqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rydzMat18AG5rMnWB146hATCZcplOsPSt8ydVr4m9TBI/uwRGx9XnKK6f3YPk1IrIuumjiw2Dk68UOblWaSuHhbkeg7ZTBtdxQLddto0HL88gcqtdbHLghzV25AmDSvwolmFSfj4VJnYtbMi7BmCkVqHaP5st5aMh/SkD3IQVXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wqy9Q+bD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3561276a12.3;
        Tue, 16 Apr 2024 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713287370; x=1713892170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MHUy3BTU7vf8OKYXFB2qGMv/9WxQZ2YHgvNS8n+tlds=;
        b=Wqy9Q+bDAa5/vPtuIGxiHI97b5f12V5RVbeWNYH8q3LXJJfzl5TdP51bvyo27/X2Lm
         Sa/ecluxj34NU6scSslr5ls69GZ0PQA4OjuV1fMW2Caqbujg8g1JtzYe6M/3MC5mY1TA
         X5hKrsOUCP+z6+fcQlz2RyEY2LbXB+JErO8XqGuIpa8vxNx2GBkP1HL/bWf8fqUKpROC
         4olIU5PmcN8ov5XUp8LZWgpnJAd1vdHscNkL1IoImJ0ikDmDjispyiVKOWZHh+qV+jfF
         RiU7Mk7x01NHJuWnccTFA+15h1PTOLiu3SFgg+8FSsPF9hkDx+VCV8tcOMVV0FFfUH2C
         QwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713287370; x=1713892170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHUy3BTU7vf8OKYXFB2qGMv/9WxQZ2YHgvNS8n+tlds=;
        b=KCpyVqv5Pp4K2p/eNNV0E2pdnRQko9dxU94u9cImJYTA9GySnvGjSccSbF6CXAuLdN
         +1r5BfekikihJv0wswL59p4Gxh8dct/PzyLQzK/LJ8NWrx2aWgo8si5KBUgiqGKEdA+a
         D/Si/TWIMI/bEbNuEuhbyJfFm65cwextC7wGDCetQF6s1INsjM6TphT3CC6+8zNpXekP
         zey6QAZxLLy6XVgMdEAJdjwUz52bKqmuEdWuGftIZRMC0Iqm0epGVeqNDENuQRRv/PGf
         Te7HzffFYvLyYcGMs75k3trsG6t8EEsr40VKvYwVbN8S89cFKxk4+GjNIJtrZFxtU1Fw
         v6xA==
X-Forwarded-Encrypted: i=1; AJvYcCXFQIPYnwmHNMibAoSDVrUau/xYVuE2mfJ1sESa25X/fds8ZkQTR7L7NGw7pDNzBCDrB24JvEYcqeRksg3a9aauk6YoQUgfrDJtInf0bXkt93r+Yi69d1mXrQ3yL2Pi6dQTqHYxgMYp8umS3ejhPhgcAOdMkEh2soHA3xcAfmARjCHY
X-Gm-Message-State: AOJu0YyRpV0IB/yFtP4dzPB0gZHuBjUpaCbyr+4jf0t9wo+TK34KHazg
	2oHYAD280Kq32UcJSDgdc0VqPfmdhS3fbbKgpnv4U1MclbcRSehH
X-Google-Smtp-Source: AGHT+IG+CRkxLfB6g57yny9+gaNCdFI1vNgBjGCWNjHyv+ieg7Qj/HQyNA7wS2R2epCfbsKCveDSLw==
X-Received: by 2002:a17:90b:4d89:b0:2a2:bd4b:764f with SMTP id oj9-20020a17090b4d8900b002a2bd4b764fmr12490553pjb.3.1713287369756;
        Tue, 16 Apr 2024 10:09:29 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id s6-20020a17090a2f0600b00299101c1341sm10182573pjd.18.2024.04.16.10.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:09:29 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Apr 2024 07:09:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, qde@naccy.de, zhaotianrui@loongson.cn,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, cgroups@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFC v2 5/6] blk-throttle: support to destroy throtl_data
 when blk-throttle is disabled
Message-ID: <Zh6wx4mXZy_EOViH@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-6-yukuai1@huaweicloud.com>
 <Zhl37slglnnTSMO7@slm.duckdns.org>
 <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bb85208-1224-77dc-f0b2-7b7a228ef70b@huaweicloud.com>

Hello,

On Sat, Apr 13, 2024 at 10:06:00AM +0800, Yu Kuai wrote:
> I think that we need find an appropriate time to unload blk-throttle
> other than deleting the gendisk. I also think of adding a new user input
> like "8:0 free" to do this. These are the solutions that I can think of
> for now.

Probably a better interface is for unloading to force blk-throtl to be
deactivated rather than asking the user to nuke all configs.

Thanks.

-- 
tejun

