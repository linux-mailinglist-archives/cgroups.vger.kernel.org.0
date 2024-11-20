Return-Path: <cgroups+bounces-5660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C569D4403
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 23:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81438B23DCA
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2024 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134661AA1DC;
	Wed, 20 Nov 2024 22:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TwZDSssb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121D155A34
	for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 22:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142480; cv=none; b=UXZTsxoa09Mng9VPfFCCDYUmYw3OLtGTD6VN+IGdhbDhgBp1ZDCg3Aq7RLeYda/5Jzkc7ORQh+h/+tv7zNS1Szb5I4BKv6AZSg+IXQbn6TBJEHbQ3s/adiye8tzUOlOElZR+fnARYIwKZJ9/wzgsdsK8LQGvSWH+32v92c2tLRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142480; c=relaxed/simple;
	bh=wU2YWz1ot07e1ywKIYfJO39eCE2GrpfOoV/pM8UoEOo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dd3IeuXSuWNt76UTkXNioOIPTIvYtaKz5fVjH5bxEIIgFbr1RGQl34zlLFFj2cfH2ccFmyLfb3jInbB9XTWbMyXRDC1oPH0jxPkFm3WHYujb13psO0jap3NIghw3YZddYK00uAEmO3j6VQX/8Nq5yGowx1E7MJ+D6fQix4KdcjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TwZDSssb; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eacc4c9164so278657a91.0
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2024 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732142478; x=1732747278; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wU2YWz1ot07e1ywKIYfJO39eCE2GrpfOoV/pM8UoEOo=;
        b=TwZDSssbVxpFC8S03z6toDV9TuPlIOQBwbo0OwxmYH1LeQALaJCh5O4mrOvn2kfDtU
         +TS8sfrHPLjtgI505JCBgpUXrK4yMlF+EkhvjnPQS/4fi1jBRnBNznDloIbOoygUjndZ
         n5zpC1/ulUy09zswYFSrD+jO3Jv+LEQWm8IyGDldrcX2TuVZlmnESshIIGtxqwMaPAAm
         ZbE/K++D5g2rpy9dGrIANlY/vxTDyX9o2Fj3AV02mGmSpuwKVyqZZ0ahnfJvXICC4466
         v6KvPv1w/k9ep9YLlJlBurxpjevPZ5G5uDy3nbYT0ljDbWstuMSnr3AogV28N9GGr+3h
         J/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732142478; x=1732747278;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wU2YWz1ot07e1ywKIYfJO39eCE2GrpfOoV/pM8UoEOo=;
        b=AF/847cTsqV0cNSwrlcqraXHqhnWRjppyz+UZ35vakV0StXFDIyie8dhUp99ZXORvB
         sXJa1K18X9QCizjAgs3aUwejScqQTUI7g7+udo9oaP1ab+kMmyzpXftaXhjhEW3hZOXm
         9xqNYrXxFfRKPsfXKTVa0VUgNFYwoGyhJgt2zk+II5q8+X/ooUKePBFafY4eM/Sc5OdH
         oz2KhLKjqJ2uXdQXzHYLBY0PzKiSVJ5WE3A3+AyzZP/r8Bn0ViXIa0NqjAhoO2Hj3G7J
         WwbG5qDUvbhlg3TYrpan04XwymTBbWrbTgW0qhmv89KYCMgF+X4H2CW5mQEgljl4v9ZQ
         Xgcg==
X-Gm-Message-State: AOJu0YyxIhAbSotCTyKOnrjVWl9PPuNHFGMqoLouuTBF8Dka+krWUViU
	RAE3SHQt/Of8GrGZKMHQ/1KKm/CEdpbLcDNlP1bnCvHmZvRcYw1PlmQ1mUyHp/N/TZpGqrRVGCM
	7FdieQN2j/NSzW0/PaRfgie+KRgsgO4gC74s=
X-Gm-Gg: ASbGncsA1C8L4tgBAKvGV0w92KkJLaSiwXuCyHPQ4lP10pdjuaS/kYHkpe0H8OlCOvA
	9E3iV8+ojx3DNLSQN7cigCDCsHP526Yki
X-Google-Smtp-Source: AGHT+IGBeUVkjJg92SwqzanvZep1ULf5FU0C+RRNR1pX/DfvPByRjqfODVmIbSnL0a1xniEViMRXhDWDqgZ1IWm+PDI=
X-Received: by 2002:a17:90a:e7ce:b0:2ea:7a22:5390 with SMTP id
 98e67ed59e1d1-2eaca6c4c40mr5288949a91.5.1732142478661; Wed, 20 Nov 2024
 14:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Akihito Kurita <akito5623@gmail.com>
Date: Thu, 21 Nov 2024 07:41:06 +0900
Message-ID: <CALytvNt3yRJKTxbPy_yASnmtdQxZ2PBDtMANSgyKMpoLyR=_OA@mail.gmail.com>
Subject: Nice to meet you all.
To: cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello everyone.

I'm Akito Kurita, who has signed up to the Cgroup development group by email.

Right now I'm just using Cgroup for work, but I'd like to join the
development someday.

Thank you in advance.

