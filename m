Return-Path: <cgroups+bounces-5904-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA57E9F2893
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 04:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9C21885E5C
	for <lists+cgroups@lfdr.de>; Mon, 16 Dec 2024 03:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2B42F852;
	Mon, 16 Dec 2024 03:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgF7vdVV"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA68F847B;
	Mon, 16 Dec 2024 03:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318234; cv=none; b=dpp/bmupFxbd2vQ3E6E7q9SZiJFk5UDNyKgt0VZ5GREPuGp05fZRRMfDHZiWNau2QBXgUigysxH5qV7zbuDyoFaKmRZNM4kvnWbQCASxJ7unlEEOPXY50bVAmrZUFj2AEWQCFhRzCLkEEHmO6P42St1RKyozSdjUQk7/hh/FNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318234; c=relaxed/simple;
	bh=nW4I2WiA+4WrJMHFwlF7cjzMLILGpsCxP43T09AbwpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imgt3qxyFdkGPp1t13drxyfAT+nAVEYLsxVLsW+CCiRQsS5GCWS/IAXO8F2niXe65msLtt1tvkMA8KgglPQBz1WFGl68g9jvaMBL0GseRDTZKojyR+5vlCt3syiow00uG16YrOpI2EWdyHi8MUN1yq78cWwPv0hSb03lTy5YSoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgF7vdVV; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f19a6c04so300414185a.0;
        Sun, 15 Dec 2024 19:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318232; x=1734923032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0RSxzZtHLWa5Q+6kfO5E00es+t4Wzex0lnuHig+VTU=;
        b=mgF7vdVV5J81nIY80Z1zQtXrt1HcCTWgmrZ/GWwXELnTn14nt3jh1JJJ/hdlOF2iGh
         bSUpKQAceHTpMe11JMmGwYvgEw1AD0ZhTqWKdmWvNeSXgn39GGXjNmM5o8/qi+jUjddt
         5Kk3KjV99ga67gkTCLyQC9BHd7kCHODg+6mp2fbhV+OBmI4y62HW6xou8/Xc976X3utS
         KTiZhPZjeXs/8atLpnfSDzI7uxuvttR4ASYpzRMBj7KTbJgX5YVR22BYklHQk+74barR
         O/4yZOgBTnEUYm2W/oHF0f1HNDXJwZgWR0uo6sOVS73Clb5ibw2Enbp8s/DEq1aohPF+
         0vDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318232; x=1734923032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0RSxzZtHLWa5Q+6kfO5E00es+t4Wzex0lnuHig+VTU=;
        b=LN3oRiWxSODKbbAxB9Aec5Gg4/Y1yKA0F0dc/ZpgiPQGgWrdCVe3wdciEBWs6m+FjI
         iOYnlPAWBbtl8x2M6CVttpVx4klym4yflQJfu3+aS72JWbM8nYmSTvC/i5qhI5tdvoys
         Auc/jgYdVz/QCah+vzCjdWWYTbtRs7fLgPO1Bp2SREX0lhKplvjtGUpmvF6TZKQGYfAo
         5LzZxS3RxZhwCcCNkdMDRcdbEz9yOhNYOvfdPDB5efyDBOyumBmvrN7j4j0Xzm+n2zBX
         1AaKZ2fxdsXJthMJ6RutRafjxFJT2su02/LfM6mEQ+mQa+vFP79TLecQHOZo5glc+0oD
         mKOA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyOiYvEsKcNsGKGEEKmbf3mKRLCbgUx0Kh4cGzqJATzS1oqFawexGhpZZtSpnL8vUmOZPargoYJv//3Ga@vger.kernel.org, AJvYcCWwgMmUlmf1oKO2/+K4n77bdjlFnooNGw+ZBzmlNtF3OPohyebhFGh3ecpiwW5Sy3EevqYLm0pa@vger.kernel.org
X-Gm-Message-State: AOJu0YyIT6FRlP13aC3xHhrt9q67ib4KCHMuUay/rQxJm4v33FvbEuKN
	b8en1oap1ep6BeRAUYKSZGOOXFhYmeXW0HMvCxu/96Ab75OUf3a5
X-Gm-Gg: ASbGncuy5YSBorolLEjOYLmNtypnSHtGuiSgCkYB5jP6H4CZIWAKNc4EeQxz2J7E6D4
	jhP+tBpYm93cy15PrkvfaK67yZLljUIgEKz6uWF+JwTB2wDX4EPnhoLUT4y/o95PXc5k4KqfQnr
	esHG6K53I7C6blLTnP8Vy1EpTmdexITg3xZ8BANvmgCwG0pyUcNXJaoC7cd8hXqd5T7TpVGzjsK
	B9MQLPI4dHf6AIi273J/NIHpwU5BoFNgMjwLAPI8yf6y8nh/x3R3Za0rBJVFnrtfXTdu2btydzG
	aeiUGuL0V3qLs3yU
X-Google-Smtp-Source: AGHT+IEgGr6llNIbgCkW+wlMTYHSK75qH4lyoJdXb5GGtlfZesaVqBcr5S7ibU40jBNCadwGzXMBjg==
X-Received: by 2002:a05:620a:a111:b0:7b7:142d:53cb with SMTP id af79cd13be357-7b7142d56aemr274928585a.61.1734318231755;
        Sun, 15 Dec 2024 19:03:51 -0800 (PST)
Received: from Joshuas-MBP-58.lan ([2603:7000:4900:4c2f:acd6:8447:bbd5:68c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7048d1c9csm184387385a.123.2024.12.15.19.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:03:50 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sj@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/3] memcg/hugetlb: Remove memcg hugetlb try-commit-cancel protocol
Date: Sun, 15 Dec 2024 22:03:46 -0500
Message-Id: <20241216030346.99263-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <CAKEwX=NjwuTZ21ZiTsT+qJFUHURrWGUbN0C+B48-cCDTOOyBYg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Dec 2024 17:30:34 -0800 Nhat Pham <nphamcs@gmail.com> wrote:

> On Wed, Dec 11, 2024 at 12:40 PM Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> I'm assuming this is V3?

Hi Nhat,
Sorry, the subject should contain v3. Thank you for the catch : -)

Joshua

> > This patch fully removes the mem_cgroup_{try, commit, cancel}_charge
> > functions, as well as their hugetlb variants.
> >
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>

