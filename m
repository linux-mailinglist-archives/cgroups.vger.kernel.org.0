Return-Path: <cgroups+bounces-7661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4B0A94433
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4223B189BAD2
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 15:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65141D88D7;
	Sat, 19 Apr 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9HIuaz8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637ACBE4E;
	Sat, 19 Apr 2025 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745077132; cv=none; b=ejpAPQPU3dLYy0muHuPfrDmIZJnyx0ySwTVdqNzh8Jc+SK2JjPAscULQSL2Y9mhsRjICDAIep59fe7qRjtUBCr8zlfQFd6rJEqNB9biDjN+5c1CaMMWBrn3u6vyHS/FOp/UOv7nA6Z4zUQttZr9ooCq7KAGu6aqU8OX3L9aov84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745077132; c=relaxed/simple;
	bh=DlaA179pUDVk3UupX+xzdV09IgdpYtb62ICAwXFuDr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gM32+rwrj4jHXgIkzlbf8nvaEVoW7rpwLenbIZyf8ZjohfpBBY8A+xRyA+66/5A1DqrUe7jfa5ZzHXFE0WxD50x7qlHvV/9kPWQQbPvgq2/4KmRt7fHh285zwc9Zx3oIfLh1IY7/q91143OX05yIh11S08M18m+dipiUGaesD+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9HIuaz8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7398d65476eso2200369b3a.1;
        Sat, 19 Apr 2025 08:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745077130; x=1745681930; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DlaA179pUDVk3UupX+xzdV09IgdpYtb62ICAwXFuDr0=;
        b=G9HIuaz8kcVsKSPP80FPF/3iKrOuFDsTfJzMT3L21MPNPaqAVtlDzBgMkLxuanmc/V
         1mjaQGgiznxvVuScBi0CUhHihbQRUD0O3uSvQRbNq9EFdNIBArGhgFeKTOBM3iFO25aP
         gWJxzdTvlz2ppYUL/JXe+x8TX7Ziw5nzSRHZgl9BuGIs8wX2Kt2Bu2UayCtYkivVefQl
         yFnwgC0VcTelF2bNCPc53WNR8op1lM9HDGX6JxVhGeL4FudjW+RIn02CP0jPvOvyKDE4
         wM7KzaPmIUjLj3K2kCUOOdWE4AKqxkQxqLCnVLfKgXZLRFPS6MdNIUotOcQjNLsWwIYc
         1Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745077130; x=1745681930;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DlaA179pUDVk3UupX+xzdV09IgdpYtb62ICAwXFuDr0=;
        b=di7uwIF8NZFub7xUmwcA2G+gWXfUZtHuGBWUd/RmfvovvmhiHG57A+aV+L76o6N295
         EQ7D22pBTYvNN1OpJ5bG6ENPUg5eZhqdEV2cE9k3XvcuqymcFV/R0S9CvOQBoE1FEDYx
         VDDO1h4VOPWF7kN8UTruqzA50wd4R/pcu+P47/B6sxt7fAnsVyOfY4KYFGo2FY0TXPaQ
         o4GCibWLzX5+nrp+5mhVZe+92enuiIG3lSA/wwjkfPPisE+YsOcRHKFcGftY01EIN2EN
         QL8K4nYZY1p/k52nTiu08hP0o52WgerwJcoAKiU1ZJFQlcWdUghns2/dYoEWWbNcldx8
         drLg==
X-Forwarded-Encrypted: i=1; AJvYcCWPR3+o9mB+HsBE4TF3D2DDF3sWbZH/DG7/5pgMtC9yDMfLC3YdHVDwXT+8vWCTKAsROJz2p/GB1b5G2Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLonlzxZcCxEu795FmlkBlKaQPeHT84aSRiYVttIXW6KYvdshm
	tV7s/wa47vK3yNC7LpVLciR0eq121I1XbQOVZGXCKNEkveTG3pb+
X-Gm-Gg: ASbGnct6re5QEHO6PHScCpNfNrdwlIoirjThERQ49hrkMpYN8ppmP9yPeVpi192fM07
	NAQDiow///9Q97aD1Hqaob7JD7yhZN4nqegj5yAoLhg9Pzwvkoy9UOdOIGlQk2lp4xkWCzVaijb
	CWz9Feg9VUVRKhFSr6/n6xEKuhcv9+Hvh22roeQmKQbSZtfG/gk+IL65Vo2ySNGNzkwTj4h1hrw
	hkXMqDk+xKnc0DyEZQZT5ByrfldHIk0m+FX6wgaC9vmfzpNhyJSOOFLEea7H1XlrFMM0ZevKzrw
	O4erRABzWCAkPZovW75Jy+hLlR3h9lvpw2FUQf2IEHA8dzlnjH4AZZKSe31rRw==
X-Google-Smtp-Source: AGHT+IGjMg5+kviz+gp0F1ryn7TU+yeHi6CJxEK1TEuwEw6ajfIscq2dZURhTwk4TSdmRlHCEZuALg==
X-Received: by 2002:a05:6a00:114c:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-73dc1829732mr8290477b3a.6.1745077130364;
        Sat, 19 Apr 2025 08:38:50 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e3631sm3571421b3a.51.2025.04.19.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Apr 2025 08:38:49 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: tj@kernel.org
Cc: cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mkoutny@suse.com,
	xnxc22xnxc22@qq.com
Subject: Re: KASAN: slab-use-after-free Read in cgroup_rstat_flush
Date: Sat, 19 Apr 2025 08:38:43 -0700
Message-Id: <20250419153843.5035-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Z_1JBt3RMATxnDgL@slm.duckdns.org>
References: <Z_1JBt3RMATxnDgL@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

On Mon, 14 Apr 2025 07:42:30 -1000, tj <tj@kernel.org> wrote:

> Maybe another casualty of the bug fixed by a22b3d54de94 ("cgroup/cpuset: Fix
> race between newly created partition and dying one")?

This issue was maybe caused by commit 093c8812de2d3, and was later fixed
by commit 7d6c63c319142.

