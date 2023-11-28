Return-Path: <cgroups+bounces-604-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF77FBFAD
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 17:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F13282A63
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601657872;
	Tue, 28 Nov 2023 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDWmC4MH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC4D4B;
	Tue, 28 Nov 2023 08:52:54 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso5667358b3a.2;
        Tue, 28 Nov 2023 08:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701190374; x=1701795174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2GFpgF/UShDGrhmadEJvLPiDWgQypGxozPNByeW60o=;
        b=NDWmC4MH7Mm8z/Z8L8CxHtmHUSKUlUQd86MiCD8Gl4OyMG+oAmYSBxx6QsGn42edpB
         DhexSvUjC493LFwfH03GUjIv3+b/ZZ9dyh/brIQjWOuSDRG+UouzNF3lRw4/ycPfDjvV
         l3cpVnHZXnESIVh5BBJUoRUnQrgr4Rbu4wOCz7kP5H3FOTY9x/TZskRBE5yX4E3gIt+D
         CfCv9jWtcFa5nxd9VqLJaaTJEiozXa9WdOkcQp6aPJyTIzYhLh1Qsp9u9z9UYchos+mp
         FCSyonoW0ZE4+0C2TKYMZE4P7xW5y7VPDE+SkP1Y51M4cH70Uv3bcZp+iGgjDvDPlQ1k
         j//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701190374; x=1701795174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2GFpgF/UShDGrhmadEJvLPiDWgQypGxozPNByeW60o=;
        b=QkTakBxmYNjNIp2Gf9m7jazJHChxAujBBm92bLQwi+dXZHjdOuKxTFjh4ZCteZy7B3
         5G53irlDVsgHhE/nnVvyhUhvg68Zs1AmnnFeItDc5r6XyIUdLJW73zzoXEQV3CYykz/B
         PoddfW1gmgOCDk067BEQfoP6LlHOdq5D6lu1y/98sdeLceGjbA614KGpsIm/wiDvn9Xu
         ITht5wnBt4hXdyukcnJ7gubPw0ag2XyI822h2D5sQpVAK4vMj/odJzT/EeSBKg9+PjM6
         EQ6Mgqrn2M4x0nhk88s1vJWN0VfCfVUtkKdSn5bN/hz6oVl6zNdmnoolLokaPh3rBfHz
         OsAQ==
X-Gm-Message-State: AOJu0YwfOuQIF5qwnlhdsoOhsDGEZQ1lkmBeeCSit7XvJmmEp6NbgpHI
	w1WWjcdKBQnff++WYspqMm4=
X-Google-Smtp-Source: AGHT+IESZLkr/1OKBV5n340oK9Jlw1VXrLMt+uC0XUIpwOTG/i3VDKrrFNQVcCHkdDaR5zTGF7B+2A==
X-Received: by 2002:a05:6a00:1486:b0:68f:bb02:fdf with SMTP id v6-20020a056a00148600b0068fbb020fdfmr20872768pfu.27.1701190374037;
        Tue, 28 Nov 2023 08:52:54 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id fc14-20020a056a002e0e00b006cd08377a13sm5045838pfb.190.2023.11.28.08.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:52:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Nov 2023 06:52:52 -1000
From: Tejun Heo <tj@kernel.org>
To: Mark Hasemeyer <markhas@google.com>
Cc: Tim Van Patten <timvp@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Tim Van Patten <timvp@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Message-ID: <ZWYa5IlXpdus2q3R@slm.duckdns.org>
References: <20231115162054.2896748-1-timvp@chromium.org>
 <ZVokO6_4o07FU0xP@slm.duckdns.org>
 <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com>

On Mon, Nov 27, 2023 at 11:19:52AM -0700, Mark Hasemeyer wrote:
> > Applied to cgroup/for-6.7-fixes.
> >
> > Thanks.
> >
> > --
> > tejun
> 
> Thanks Tejun!
> As this hasn't been merged to Linus's tree yet, do you think you could
> Cc: stable@vger.kernel.org?

Yeah, I can do that. That'd be for v6.1+ and fix f5d39b020809
("freezer,sched: Rewrite core freezer logic"), right?

Thanks.

-- 
tejun

