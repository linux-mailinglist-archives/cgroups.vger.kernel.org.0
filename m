Return-Path: <cgroups+bounces-2373-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010989CB64
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 20:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54A61F2202F
	for <lists+cgroups@lfdr.de>; Mon,  8 Apr 2024 18:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EFE1442F4;
	Mon,  8 Apr 2024 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k77n1JSQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227E014387A;
	Mon,  8 Apr 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712599326; cv=none; b=khghV1IKJ/2piD//7yI7MAWdhTXqvTIifn8B0BnOm5qz3v4AujiKL5i05WusQMiPz1VoBaOSvTdH6wOEs072NO8/IPVUUxS0YGK+gCH4USRjvIVRgSpVi4icrwUiNU3onWZYgLjhQG3I+CkGDEzlkGmslhy59KhaoLHiDsHNx84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712599326; c=relaxed/simple;
	bh=vkBaDTcUBTrefxXYlzFyE1aOMi1WQ5AbdAKrTQt3pWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSJC7EaN0QeCzgxaCaqkj5tvNf40Xl3S+Ey8sZiFxNUpEigMBMvNYfrbBnI0lesXPQcOaejr1NsUHyBFKRGlEUc/CPLiONb1vbmLLNb4dWEZWMSKXT8L7JT6Okq4RiHSLdz3BNMSTDzRyZBIJVCrbwSKI5Ivxno1nJLhrJAowNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k77n1JSQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf3f001c5so3921004b3a.1;
        Mon, 08 Apr 2024 11:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712599324; x=1713204124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfwqzK+afBMY9Zy8h33Ym+tRlLN7tPH7S1iHp5xkDtU=;
        b=k77n1JSQsE4xNwmflCwCAUaVGoXXEC8XuFiWbg9oTW55E0U9AP7HHVlRDW7BczKmfg
         mRMGzdSKCpngrzwMf9L+qdfiLJVMAJ20sTwdn+zNapiFo5NCgOAbJXbx+AR6LsqayiYl
         PPjoYKmQeyDzClBMXKUcyi+V9q8+dYRIFCuYb52W+H0Yy9RT+bYwOV/A06NRNJogR+66
         IkdFflonFsS/iMYTFZgdkrKmEE5p3mpubG5X72olJEKUIOwroOd1AIqJK6n7QKs0vuSx
         8EDu1vcSmAUPUgOz0RNajqjMsOz4AU2vvTmYF6Qhp1fOrWhCVQ7Bx2/VJntI7yvDm/kj
         N9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712599324; x=1713204124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfwqzK+afBMY9Zy8h33Ym+tRlLN7tPH7S1iHp5xkDtU=;
        b=qNvjunLL1xCPZeB5k6ZHCdJFMRKufZJhjtHn/pmTPHsQBZGrINglb+Jl02iVGnc/cN
         50JA6NbANZlZ55ad3EPiJjQ/7G2GiLZREPvZjVVATOJq2O0fIIQJWkYuuBKUaQOQ/Tts
         d6cQAK24uCE3484roXPAxeP6aTD1H1qIPaEAnkWW+L1UB5sdqjxQG3sv4th3rdhq51ZE
         Z5QwTuUju+JHqlABsAHXQ+6Hj7MwQLZnmXOuedXAQ7QWHa90kaF7E2aV8jXQ8MsFQxln
         slZiJ5hMxvKXGWl3DLTqzC83JceCFqMnMhxD91+rE4SN5O5x3+5Svq2OtIucWdWsE4iq
         POzw==
X-Forwarded-Encrypted: i=1; AJvYcCVYZdE2B+uVpSIN2TrimTEkiiMSd/q4I4gBC9EHzqbtPpJzV/IQyrxIF5OCMOvUt6/gWx2C+Aip4syPmFs06jlN4VtA0RV+TzXMUeaE+4Cp9g5QtJMshtJapt9UzUoqz9LduVEfvu5UINzCj9t/W4UT7puqFrBaDyZjTZPyNseSNw==
X-Gm-Message-State: AOJu0Yz0woIsEwzz7yButLBQ6923x0IKnKvhNHKmkPBrLcrmCDW/k6l1
	zOzgc+gaoQT0ZZ+r+95jiNeJ7SmNIUJklngKMOonkO0uDuUResOj
X-Google-Smtp-Source: AGHT+IFE0N9ybTKgUYJ7RoYqHLChlg+pN28+lWShPpbkU2HLYdnAgjjiMQ6pm+hporQuV7Jb9r1q8Q==
X-Received: by 2002:a05:6a00:2341:b0:6ec:ee7c:141c with SMTP id j1-20020a056a00234100b006ecee7c141cmr8743216pfj.16.1712599324354;
        Mon, 08 Apr 2024 11:02:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id p4-20020a056a000b4400b006ed06399e0csm5830538pfo.72.2024.04.08.11.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 11:02:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Apr 2024 08:02:02 -1000
From: Tejun Heo <tj@kernel.org>
To: I Hsin Cheng <richard120310@gmail.com>
Cc: lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: cgroup-v1: Fix description for css_online
Message-ID: <ZhQxGgVo_Lox0EVD@slm.duckdns.org>
References: <20240408035329.5175-1-richard120310@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408035329.5175-1-richard120310@gmail.com>

On Mon, Apr 08, 2024 at 11:53:29AM +0800, I Hsin Cheng wrote:
> The original description refers to the comment on
> cgroup_for_each_descendant_pre() for more details. However, the macro
> cgroup_for_each_descendant_pre() no longer exist, we replace it with the
> corresponding macro cgroup_for_each_live_descendant_pre().
> 
> Signed-off-by: I Hsin Cheng <richard120310@gmail.com>

Applied to cgroup/for-6.10.

Thanks.

-- 
tejun

