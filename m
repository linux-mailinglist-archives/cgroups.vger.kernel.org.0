Return-Path: <cgroups+bounces-3500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FED9244A0
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 19:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33ECE1C22519
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 17:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D731BE23F;
	Tue,  2 Jul 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7jBBI0c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F015B0FE;
	Tue,  2 Jul 2024 17:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940373; cv=none; b=OCB6b/kNPztqyiJbht3u7pLZf9FxmZMejJ2kCvT6snAvH1NvYvJzXnidPthCUC7ntnWsXmfHOTFhp6d1gpv5W1CFsmOzhMcCAozMggVOoE2onNHaJelRQP2X7vDxJUvGjfcX3ER7ocBuCQbC9kDjGn5TXM67V/I0+OkxQcGhQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940373; c=relaxed/simple;
	bh=DgA7cfU5r9OZRCmLMvOPAI4mDa2XadFyFMbIQBBRS50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWT3i798pMn+cbWg7OkQFV9NH+Nrxz0j8ExPTXPR4Cilkcl8HAYjR5HCbaQOW5xOQCJHn90H2xWzV5F+I/f2w7+8QVroQeGDyQFoj0y7KJ8eCFgOIZXYC6q8ezvw6HeEBClgiF0+v7OrPSDOgg2z1E5YxKYI8UOEAOSIl4pLduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7jBBI0c; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa0f143b85so31719735ad.3;
        Tue, 02 Jul 2024 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719940371; x=1720545171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijlINSkzKP0UYjx8QkFk3CJQA3Xa/exZyxHOlqZ+kd0=;
        b=K7jBBI0cKxoRlC0Z9A0sObvFQLtU8xFznK18IzxwldfJc+1z0cVdcNLi/UZRV/ZYEc
         clFBIPHhSbQv4kbOUeocUOxS8W0vYZ7t8Cqr2LLclsnJfkg5XZFyWFHNjh0Rp6r++IBg
         6KS/Vz7HipU4HYXyTnyGWEO/XV2Z13sNUsP46GELU23ccUvaRDiKYSUmhcDDGAp5QEiH
         +fM0G7fF7qsTCYRVQwaxqwGAKWPf+msLiwh9k2RoE2v10PfwPEb9aBtvR86G190j0p46
         8tCTpFYy9mQk/ep/dWi5gJwfRJqYmcsBxwhuwI70hgSbZf/tAGqQXmM45eD69+RU1pHU
         Koug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719940371; x=1720545171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijlINSkzKP0UYjx8QkFk3CJQA3Xa/exZyxHOlqZ+kd0=;
        b=wiL8CoJpv0lXOvFb50zmv8orPrNx4D9qRZ18VONE1DLS7G2XqXwN9WQsuF03E9LH4F
         emN/birFBLAaWbRuGjP4ugYbX8xhN074aenB11ugVKrvipSD6+Kxn3GrrCB/IwEL5rcE
         2ObYpc+g2dnSYVC3gvwm5p2fBDrY2qMQg0kC5Oc9NxRkBW8qP8VwjEMGEXQZc0BtKJSs
         i/FK14TJm0D2o6KsKoACdbzMrsH9m2+Ms5CcnAwu/9g13zmv01G4c/tQTZPKffHrBX0K
         yJfFkHpWv/UjHrVcUdUemFLRzHotJTCpzTtksrFEV1QWszvlKw2FXKPtkjMRF87Cabed
         vWsg==
X-Forwarded-Encrypted: i=1; AJvYcCVP0jBSt1EDoc9LmFn2ilr2SY3BiiWZgBH4YfVWSUWeXM1FYtJzDMWQGL2/PIWUrddeFX/9N1HYO0pTEgKd6p7u0ITZfUy66A==
X-Gm-Message-State: AOJu0YxluwsY6K4UTEESirlVtXJuoTV4iNfG8gdZjg5ZdqQ+3zqJ+4Kb
	On1Ot/eMpx0lGy1P1twSnAYPnc76PUulDatBJbGIFCKdhQxbVT7zGvdIkg==
X-Google-Smtp-Source: AGHT+IFtvOAOPvBw51G6xGDnGYQR4jj0xhEcOUX9FgXruavu5hhPth9FgxN59oXFPCdDtUuxbpcupA==
X-Received: by 2002:a17:902:d492:b0:1fa:4b9:cffc with SMTP id d9443c01a7336-1fadbb5ecdemr57563255ad.0.1719940371388;
        Tue, 02 Jul 2024 10:12:51 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d2060sm89296925ad.15.2024.07.02.10.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:12:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 2 Jul 2024 07:12:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Vipin Sharma <vipinsh@google.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] cgroup_misc: add kernel-doc comments for enum
 misc_res_type
Message-ID: <ZoQ1ETVlajXTSbr9@slm.duckdns.org>
References: <20240701234937.8234-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701234937.8234-1-rdunlap@infradead.org>

On Mon, Jul 01, 2024 at 04:49:37PM -0700, Randy Dunlap wrote:
> Fully document enum misc_res_type with kernel-doc comments to prevent
> kernel-doc warnings:
> 
> misc_cgroup.h:12: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Types of misc cgroup entries supported by the host.
> misc_cgroup.h:12: warning: missing initial short description on line:
>  * Types of misc cgroup entries supported by the host.
> 
> Fixes: a72232eabdfc ("cgroup: Add misc cgroup controller")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: cgroups@vger.kernel.org

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

