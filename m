Return-Path: <cgroups+bounces-12480-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 066CDCCAA6F
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 08:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930A73010A8A
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E2239099;
	Thu, 18 Dec 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So0nfZ3F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F8239570
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042755; cv=none; b=cuIzfuhySzLNmt11pa7eyg6bXoNSUuP7Bi8hhnb5neNQ98uKm9XwCWnMluLZlvtw7Ct8mAYxtH+HJqBQRxCnCSTLfIYeMp2xkDrgiJ0idImnoN34cqFu4yOT1KmEIvxXlDcmmWNQkQmsUox90uSodRGokWkUGki/D2igXkTok0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042755; c=relaxed/simple;
	bh=AxMH9y75DByNtx7wH1fMaghYsgpL8CMGuu42e3S7Bc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sK+G7CQ5Kfbx+wdow05ytC0Vtcfns0F2Q/g7deeQBipXvzDiglP/pWgG7mDWumomTN4GsktiqhUg86UeE8mFuIZfYSh81xeRQq8gHP3zcAj8aja/RymgXtlnGF1MgqlcpY1z9s0uqIuUccTSTAy1zLcWUh+k6CWpnKzVZLQJfvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So0nfZ3F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so318719b3a.1
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 23:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766042753; x=1766647553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4R88Xn/h+8caxsc4FK/Mwtw22v+IgmOvKUTH+FxRso=;
        b=So0nfZ3FQbhyN8yaZvi+hlmt4YbM1sWVVG7i6dSVViFs5q1Oylf2IkD/czhf12DStb
         DpNx1CHYPUm+/B52SU0eEDDX/bxt8ILa+carl7tnFa3KTSnJUhV1aUcm0M03YiQuWEzU
         moU/luHoTKKSlaP/HDziD3TP2h8+f4Tgke20qIZ37lp4OkCb17vn99czCkLR9Xg/+uOr
         7x6rhM2vVu+WyTfvVEIYzmp5D14Wrmj2fozPBcvsfxf3jz0Mm+Sl6aLXtkjQaz0aZTWe
         9ZDsoWOtwNJ4OEVPDFU2qO+cpZ3gEh0uFNu+chFMyqKr3PzMIX/NizWuaGAnovebyTpm
         krXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042753; x=1766647553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4R88Xn/h+8caxsc4FK/Mwtw22v+IgmOvKUTH+FxRso=;
        b=GZwLIoZePa+ORoAZgQpOYqeuDFCMUihoEO8HgNJZyEs2MioPTdo8IQrWoGoMKFM4k1
         kYeY/dxd+7HpYsLcoPLAwjFh75LDKr/ANxkoumgSmFx56qjKFB1OAbDF0P5RFn8XaeE+
         YWFishMKP+3qpbdordBb8kF9ieGXwZj0WQEkCMIHAY0YCmxmS43dXbREHBrJkecCwsuK
         880b5kM3HD72iPHRPbqdGnrFwYQ7G84xnXTF2enwLHYX99TN3OX+EPfITOT1Qug3r8b4
         JZHOXp2F9UbJYOOWFkpNLVxQrWkTxynEIaF2NxpA7q0erzVCHo6sNPnKDGiivy0v7FM0
         CE3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMHqXMwpwTwdvTHDEFLwxteXSCgFyaQ+sYd2+YuWWmUDJzql2fsuqG2x2RiGhR136YNm4FDjrv@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+guznOdT0o5USFqAsqrtxJ+FzxI+8Uq3tdSA9ONXwH2vyUYvz
	kb8FVc1oqG9hz1LHy2kTWjiQJCxJ0ARRxjZvCVZsP8+1FXPoq02LtUDx
X-Gm-Gg: AY/fxX58+K3DLoeEB94ITmdTJSnOnZgYKpu3DqkmTT6CptKZ941FPVQ0+O2P5GCu7BO
	LFVvZhaVOEy4NyU6HTHkqjbJRvh5OD1LQSmMTtdmN6POHONZEXU+cN0Su8heBbh+wOsNmJVbXDW
	YbDxlrZs9U7MaxzonMXdU/xO1Bt46XNltOlBUj9mK5ImZ8yogzRFQXHOOLsbn/T25+lEPhtks+t
	9W8iynRC/aY5TYN97/Iu+ENqL/9zxlAY/4zlNxAFLoHKJRMTCUIplUDq4COaZOb0O0kHApOV9g2
	jsWy2kwj1LREI6zvU/A8Kuh3hmficJTaK6zqu2HtMx9na+oe6TL9r3zkMB12ztITtfDJ/J7RURR
	DVu3wMXoHW2aOluWe69xrbnj8f1RlXBMrL5RAawSFims6hRpyNxNHWBlHTyvYJQSfolp7gj8VSG
	/0C9CvDgvQ
X-Google-Smtp-Source: AGHT+IE7QD6jcxGZ721fK16jncezgZTI4shZ+xr6T/MCI8KS1Fg2nLGW1aiuenpQ0XBQS71PTipzjQ==
X-Received: by 2002:a05:6a00:3499:b0:7e8:4471:ae68 with SMTP id d2e1a72fcca58-7f669a8e5bfmr19659120b3a.52.1766042752688;
        Wed, 17 Dec 2025 23:25:52 -0800 (PST)
Received: from ubuntu.. ([103.163.65.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe1427026dsm1595735b3a.46.2025.12.17.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:25:52 -0800 (PST)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: hannes@cmpxchg.org
Cc: akpm@linux-foundation.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcg: reorder retry checks for clarity in try_charge_memcg
Date: Thu, 18 Dec 2025 07:25:41 +0000
Message-ID: <20251218072543.5071-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215204624.GE905277@cmpxchg.org>
References: <20251215204624.GE905277@cmpxchg.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Johannes,

Thank you for the feedback. Let me clarify the scenario this patch addresses.

The task_is_dying() check in try_charge_memcg() identifies when the
CURRENT task (the caller) is the OOM victim - not when some other 
process was killed.

Two scenarios:

1. Normal allocator triggers OOM:
  - Process A allocates → triggers OOM
  - Process B is killed (victim)
  - Process A continues with reset retries - task_is_dying() = false for A
  → Unchanged by my patch

2. Victim tries to allocate:
 - Process B (victim, TIF_MEMDIE set) tries to allocate
  - task_is_dying() = true
  - Current code: wastes retries on hopeless reclaims
  - My patch: exits immediately
  → Optimization for this case

The victim has three safety mechanisms that make the retries unnecessary:
1. oom_reaper proactively frees its memory
2. __alloc_pages_slowpath() grants reserves via oom_reserves_allowed()
3. Critical allocations with __GFP_NOFAIL still reach force: label

The retry loop for a dying victim is futile because:
- Reclaim won't help (victim is being killed to free memory!)
- Victim will exit regardless
- Just wastes CPU cycles

Would you like me to provide evidence showing the unnecessary retries,
or run specific tests to verify the safety mechanisms are sufficient?

Best Regards,
Dipendra

