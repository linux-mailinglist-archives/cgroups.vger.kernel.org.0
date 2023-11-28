Return-Path: <cgroups+bounces-608-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CFE7FC04F
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 18:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642BE282A2A
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 17:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8984E5CD14;
	Tue, 28 Nov 2023 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3cdw0o6"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F48E6
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 09:32:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b367a0a12so53755e9.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 09:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701192733; x=1701797533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJyIox/fp2fBmF5ORORc6mIFmRJKaIKe+cG1xBjp8o8=;
        b=H3cdw0o6i9B7BlkgtdPTK0qDLz/zAtYw5eLZFtspffj/XsjUWO7xTgIUtlJ+Sv1/oQ
         4gLt34pYRLiklnNX+/7tG1IdlSTydBmp3ZYWq9+lqu4etUCrF++vywgRcTwZfbL+Kpx0
         /a+/gve3P0LxrR4e+EXyjZMAFlWMUvT6f4tsqTjDNJzbW/jR6VbaWABcrGR5VnuREtb0
         xdfGbEp7MyJcuY1etq71SIZdKdUjaGGLKbazRS6COgxlzf+qgW+Juo80FXLbOoxLueMP
         nYvgrA/6HAF5jvlYxonXp3EDtRuBO4Bsm73c+Jy4jj99QfbTfYVnBuMDWAd4SFzwXapL
         HpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701192733; x=1701797533;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJyIox/fp2fBmF5ORORc6mIFmRJKaIKe+cG1xBjp8o8=;
        b=MkeynPi7X0Bl1XbU9ZNzNA8mvR7DKvjHua597KpqwDlj+i5itg86V6Pw38zqKktYs8
         s57JkknfrHhF9hzBKf8F5m2eQrCnMDPkuiC7tNgVjTSj8H6HOHVYtBBFxwzH3miffMKK
         JpjQxZnJcnz8Cq7bw/2luShX4T3pcQ8zVjqsAmyM1qKclaAb727TI3gmKr/+FUKCASBS
         MTlJ7YrYwVmM7e7AJBMshdkVV6xL738Vw34K2n2Tgrke8MW8PoB0T77dyq61Y0TtIQpW
         QfGr5Q+ui76MKbAoDMDUIw0BJfJC6BLb87egUdy85mgsUm3ozrNYNpSDBRT1Ep1tN7CI
         ISKA==
X-Gm-Message-State: AOJu0Yxh03F5Dusx5Pgb2i9GcobG41yiTR2DM37Ax/Ov6HRlGl4sm5Yc
	46fcnpm9fhlgW3buolVOJ+yE/Yo94/+nd5sqZXNdz63HnScB5IA94J5StRnL
X-Google-Smtp-Source: AGHT+IEc6Z4SpVUZAk2CF7793Z7n3QqquvlPQt5tnx5NSbillEpYOmwy7C1hitmTJzSl1aG/3dNSEggEj4OrHsC8Fjw=
X-Received: by 2002:a05:600c:1ca6:b0:40b:4228:ee9a with SMTP id
 k38-20020a05600c1ca600b0040b4228ee9amr384291wms.0.1701192733522; Tue, 28 Nov
 2023 09:32:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115162054.2896748-1-timvp@chromium.org> <ZVokO6_4o07FU0xP@slm.duckdns.org>
 <CAP0ea-sSvFGdpqz8Axcjrq=UX0watg=j6iBxd1OkNeKHi_pJ=Q@mail.gmail.com> <ZWYa5IlXpdus2q3R@slm.duckdns.org>
In-Reply-To: <ZWYa5IlXpdus2q3R@slm.duckdns.org>
From: Mark Hasemeyer <markhas@google.com>
Date: Tue, 28 Nov 2023 10:32:00 -0700
Message-ID: <CAP0ea-tJJAJ0V2Wk1j6cHxEscA=J9RByVWBBCRYMD3u3hNEB_w@mail.gmail.com>
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
To: Tejun Heo <tj@kernel.org>
Cc: Tim Van Patten <timvp@chromium.org>, LKML <linux-kernel@vger.kernel.org>, 
	Tim Van Patten <timvp@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Yeah, I can do that. That'd be for v6.1+ and fix f5d39b020809
> ("freezer,sched: Rewrite core freezer logic"), right?
>
> Thanks.
>
> --
> tejun

Correct. Thank you!

