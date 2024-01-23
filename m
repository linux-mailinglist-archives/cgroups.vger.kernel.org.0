Return-Path: <cgroups+bounces-1224-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D364839A8C
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 21:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47BA31C2755A
	for <lists+cgroups@lfdr.de>; Tue, 23 Jan 2024 20:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF935251;
	Tue, 23 Jan 2024 20:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYhDXldT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CACD4C7B;
	Tue, 23 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043027; cv=none; b=Sgr/OIeSp3fnEeYpRn+6XKDyKhet7jzZG3oabazWz5oCBFcpr5cPp2jWRGm3K5hOjCRl15niXuVlFfHp698pvQsnMd7h1N02CSHcvv1KIhq9IJCX+W49BPmcZCULVMN4V3rRmrHzJEg7kkTIyEO7J9IvEvg0Q/pIhR0cApBSmnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043027; c=relaxed/simple;
	bh=ZxfEKnlnaw+rGM8iMvBtgSrhl3SWM2LQXvRzwb8KlHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkdFaJLd2yfikft+jiBJ6AGWkvjL97WucYp4p8nzOkQOrtsaJmbl/KJvx3Et9VnjUUCPzX4X0Tz5A1KZTe8zW8/BIOzVGbyBVZgloZjEJddyDsw5Vw1da4F3+lLIru+rhv5SvmnPlPoQHw4I8tpySld839XX1mUIqS0HQcLQU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYhDXldT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d74045c463so18522415ad.3;
        Tue, 23 Jan 2024 12:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706043025; x=1706647825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wHG2EieQD06Nf9oCwM8RBtPpi8GR10IGH/bpyTozQ8U=;
        b=WYhDXldTRUMxHEuk5J1dhe6G9ELJbjefVvE57RD3k9pw45O6bufA3eYHovdIL3eZM1
         1YoLPl0kEFH5h7D836XdC7USR2vc+V/YgAeKa798j7Sray7RXjOYXyFRiitqTmL1bbxa
         Q5eKR1l7DgyLRwKyxNTcaX/mzemCvDCa2p3ZeSPd7DPsO2eDsGZTmT6qVFNgNtNegqPz
         GZrXZ5xrkRAS5w/v3AP1sL3uSqzkt777+cQQvBKlJDB70WOq3K84vra/0nAR5Mtcx1u9
         1X5g7jydA9nHG27qvliVKw2zwj/LInxVN/xK+r0+P0ji6xXW6dLyhG7Hd2pJmDYHSAFG
         vDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706043025; x=1706647825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHG2EieQD06Nf9oCwM8RBtPpi8GR10IGH/bpyTozQ8U=;
        b=beqTP8w8ybQSlXhi5BrRDMsnyYb7RgM5WhVO8Z+sQsvBAGOvtwPskWqyVpr2sybT9K
         5ce/K6UyWwYUrKybxZgtHsHZeDwG4D9yescOsq/saPqfdOFoYpC5UU7uDKU0sLLOj0Yh
         CkwYOz9sTe6b6QQexyOgAdgKtM4YLzDzZlcyHJeaODxYSBx3j6Ijk6hzgX4SiSyWIXVj
         Dy0Hj2EN2xXM8i5qNMDtch5Usf3xSD0KgyA20bsj5eUmHTqx8s31aiu2lGKbomcKyQd9
         8Sn0T9F9q6Jt3ptdANJfA1LK5rS2HdnHF5TANIWAqZPr1WvLnChO+lvGPzJ/IAf1P0GV
         diNQ==
X-Gm-Message-State: AOJu0YwkcXsKebU5ZmVKiNF3FWaRqO+pJtim6V4L+enmqtPLOTYgx05k
	TMQGEngYa/mQn5UxHhojnDQuzuX37BkLvxnIq0i5nF0CkeoLHcBE
X-Google-Smtp-Source: AGHT+IFuRaC2Oih3szcxgEEMS4pTKR+7RCIO7aSbmH9pnHKFYTiTaWESnrVfq9OSWGOFd6fRkQUgXw==
X-Received: by 2002:a17:903:124b:b0:1d4:fd84:bee2 with SMTP id u11-20020a170903124b00b001d4fd84bee2mr4758036plh.7.1706043025465;
        Tue, 23 Jan 2024 12:50:25 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902a70e00b001d75c26e857sm3109452plq.288.2024.01.23.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 12:50:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Jan 2024 10:50:24 -1000
From: Tejun Heo <tj@kernel.org>
To: lixinyu20s@ict.ac.cn
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] docs: cgroup-v1: add missing code-block tags
Message-ID: <ZbAmkHe7R7KJ81rs@slm.duckdns.org>
References: <20240121061336.3500233-1-lixinyu20s@ict.ac.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121061336.3500233-1-lixinyu20s@ict.ac.cn>

On Sun, Jan 21, 2024 at 02:13:36PM +0800, lixinyu20s@ict.ac.cn wrote:
> From: Xinyu Li <lixinyu20s@ict.ac.cn>
> 
> Hugetlb.rst lacks two code-block tags, causing a formatting issue.
> 
> Signed-off-by: Xinyu Li <lixinyu20s@ict.ac.cn>

Applied to cgroup/for-6.9.

Thanks.

-- 
tejun

