Return-Path: <cgroups+bounces-5515-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 817989C617D
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 20:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0103EB227AE
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B40C206074;
	Tue, 12 Nov 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1XkK2chC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Z7Qx0DP"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A8206072;
	Tue, 12 Nov 2024 15:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427040; cv=none; b=bgOCgG6wpXvjn4VIrAjA3477iGUkp2wTBnKSxquDam+Gsyr4VJpr7hy8YLcdj5nGR6nUddHMjVEPwgJ07S0sf994zrokD4YL9Ex/WrnLhAP2ugkIdXmkdYnOtDjFqdvlIlcBhustI8vGmluyxgu7OmrSN8RDttwMq4XW4W7lzH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427040; c=relaxed/simple;
	bh=cYjUup2uaMpA9UuyvnE2JFhxRMV85caWvV2SGSO/p4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dWiwZjZ6nG/gH9EmHT5reB6gCJqfNRFkNjlSbZy2pz4mFZ0xfqDhQRn53GCY2cGDiDoiGqLSrqLVtUwQLtCZ0LWETR9MuxA8OX/lltzolynekY3JV25YkkcPvNb93DUf7BQTNFuYNUZ9pEni3VJvZgxprcP/ISgVVFjRTWLaEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1XkK2chC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Z7Qx0DP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731427037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=evCvo/GOJRf/mT7vzTMHE19/uCRerVB33FykyHO2fsg=;
	b=1XkK2chCrBnmVGrseS40oUiNk+8K5zP5W08ov84PzwkndswHNbjmrIudETAI3FcGE4xFaa
	YLziVeUGWyxizL/uHv5U61bqEl50zNRXaxwlUhKzfajzJhHqmSq3UdJh1qqlGiKonbucfb
	FxvXhIFXhLVBCYOBCYFO7wy8EmT4CdTUjfG376mC5NRpbx3X91cjiabLysj5i7PmCRhCKa
	unz4JZpoKtpLrhIntPDk6LceW0c6jvA45nCH00aRyw4tsqtAmLbygY8P2ppbXgPEFtwM3k
	BPXJUqByPEl0XU67fGLWST4J9+uQLnaVvaSz/Bi851ySmZcd7UhEMEWc+F4dKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731427037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=evCvo/GOJRf/mT7vzTMHE19/uCRerVB33FykyHO2fsg=;
	b=2Z7Qx0DP8rlB5zFylKD1ZE8A0BTUimr4t4U9rJ4L3M7tLolXEA01QGWcfpzHBt32vJ2TMO
	mDCQMuzkmKiKKdBA==
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de
Subject: [PATCH v2 0/2] Let cgroup use RCU for kernfs_node::name lookup.
Date: Tue, 12 Nov 2024 16:52:37 +0100
Message-ID: <20241112155713.269214-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is a follow up to Hillf/syzbot report. The thread started at
  https://lore.kernel.org/all/20241102001224.2789-1-hdanton@sina.com/

v1=E2=80=A6v2 https://lore.kernel.org/all/20241108222406.n5azgO98@linutroni=
x.de
  - Use RCU lookup only for ::name and only for cgroup.

Sebastian


