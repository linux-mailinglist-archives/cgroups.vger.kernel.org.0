Return-Path: <cgroups+bounces-4378-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9DC958CC0
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC42D1C21CAA
	for <lists+cgroups@lfdr.de>; Tue, 20 Aug 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAB71BBBE0;
	Tue, 20 Aug 2024 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBxTDU83"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108231922D3;
	Tue, 20 Aug 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724173618; cv=none; b=oeq7sqI47lTm4IvWWD7g+/lZ+hWqpUFf0KDLPfmp/450yEoPcg3pZzwz/qGAWzTig6CDjDQ4uzN2pl/HHASlsP3h/kAjZL1OIXS7HrWRtps+LmAjW7JLO2VWhLSF9cnnqtTof5eQiihlAN3On1EOriViuAoICxCCIkhpAzo+SHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724173618; c=relaxed/simple;
	bh=54shCYsL8YfYX+WHefs2opAhdifYsoSBgiNhfTTnphg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2yDz0yymf/x49vwMjRg1vqmLWMzXac9KJexp2eGqgPhCZRZUQNNJiPxahzbJZM7k3503A+nixtmWIoRSb62tBnHMXjOBcu1EqXsBfVgoNGXrnQp1UYCJgYPBL0B0SANAprCmAdVy/eXANbyZMxSDLtuTgCURUIDmZER7x9j7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBxTDU83; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20208830de8so34561515ad.1;
        Tue, 20 Aug 2024 10:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724173616; x=1724778416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alquEjzt3pV+GF2ki+CPGlhnJrvecsAgoJSLznrwbU8=;
        b=UBxTDU83d5muAqIaKURFs92gsc531c0S4m/TOp5PwD4xD0ZCPfEUt8Skf4R0kcYuLH
         Hw75Ig9W1VyGwHDaBwi7MIlFZE91R+cSS5KrpkkjDzNEIwL5f5FnBd5nJCK264M5HhtV
         CraWuO17wy2/jFkRGIg8Z8jkNFYM3vNPbsrItoAk843yWZGvN2a8tEJwRfns8so0GwBI
         0SxFIYXXN9YYd6CabtPwhZU5/eBjjeDPvuBDS7qcmfLWdOijGKM62xbSfzngnklzArdC
         WOI2s5bYoLJl4zDENB5alK70beJK7pqQxrp6nhdGWqVxCZ+Oih6+tNl6zVwDsqQaLnyo
         Gj/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724173616; x=1724778416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alquEjzt3pV+GF2ki+CPGlhnJrvecsAgoJSLznrwbU8=;
        b=UOFadAbb6NEWVZGfOoWgkageP04bJS4sJGJ8chxScu5JYXDLTiQZWbduJ/P2DQOIs4
         OXxE5DcHdoya/xSPG11AVp6AlUiFRpSehaxXj8QC5Jd69gwFazo2pbnW80KBHZIb4ypB
         /5Q3C4aBrM3BJXGQOiM1vyeCkcReTGiWWC/NK5CNIfEVwYEJ17X7R1rC+acze9aNdeNj
         kAezKkcrYjOx0oiUTLBN86hdekpPrIpfHXWFokQQsEv6BY0sfylXqe+Kg8T1yYvm7xhA
         Blzd72zQmKAiCOJ8ln2gLjW6wbnY2gih8WOVOPGiB92umTz7QN9nXJdhLIaB4mQTdf9f
         paKA==
X-Forwarded-Encrypted: i=1; AJvYcCW+wItVQa2xosAjocDG7qtWglc3GZkDZAwhWlNFMJzN1XWQe9lAoJ+t8nFY+2ph+9ZYpPE+09zB0s3YPfk84Tyx4ZvViSio+sXe7EEo7wV3debSUQLoF8q1E/2DAbmZL4d42jxudsPrrgttMaUP5DSQGHYY2Ox3fopy3HjMnKllQc53
X-Gm-Message-State: AOJu0Yw4VpJ7hAhWuA8Rtp65S42gXUrDXVOuyJPpzQTHX/A9cm3qb5nf
	k1kHZ3/h/O2JjkY2tWkkbH/AFXjlFSrQJnDEd1IYe4wpsbVKPozRVWKodw==
X-Google-Smtp-Source: AGHT+IG0ZJ3QnQNSFMIEj2D5KZRJp7M8hlmcBNA0ELfAoeqxfCY3D5JUeqlYGGLA68f5YTVJI2Koiw==
X-Received: by 2002:a17:902:dace:b0:1fd:93d2:fb67 with SMTP id d9443c01a7336-2031517e689mr34277165ad.52.1724173616231;
        Tue, 20 Aug 2024 10:06:56 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-202592bdf7fsm21652645ad.181.2024.08.20.10.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:06:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Aug 2024 07:06:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, axboe@kernel.dk,
	cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
	houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
	yukuai3@huawei.com, lilingfeng3@huawei.com
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-ID: <ZsTNLor7XoJ9dOVx@slm.duckdns.org>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>

On Sat, Aug 17, 2024 at 03:11:08PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> This makes difference on the behavior of throttled bios:
> Before: the limit of the throttled bios can't be changed and the bios will
> complete under this limit;
> Now: the limit will be canceled and the throttled bios will be flushed
> immediately.
> 
> References:
> [1] https://lore.kernel.org/r/20220318130144.1066064-4-ming.lei@redhat.com
> [2] https://lore.kernel.org/all/da861d63-58c6-3ca0-2535-9089993e9e28@huaweicloud.com/
> 
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

