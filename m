Return-Path: <cgroups+bounces-5586-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6EA9CFB5D
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 00:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80021284E81
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 23:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC8F1AF0A6;
	Fri, 15 Nov 2024 23:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGsZWHPM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C621A4AAA
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715071; cv=none; b=Wwj1dBv27UZtERVCEEVPeSAMFWWkus4tQMMNpwCNvzNu+U7o3q+hVxf8TxIDRgKLbK5TSmuusVMyziQWytClJbARdvYarRHZ6+UJvzWhDU7nAHXebf+PMECmWC3WdimPlj5b+K3aV1WCYWg74Np+qf0h5K6I8upx4i9Ph2YOwQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715071; c=relaxed/simple;
	bh=4pH/4jK8LQaD3zhKr7EXmPSD8fui22bOqTjbQOiw9nI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=F/d2ysHOvbtUnhSabyCmzN+EEBuQb5XlLgMIcanvEGNfDql2aey0x0DZ+ud1h/AuHe+1o8NtmzS5GzXhaziO9MKpL0lUo+xlMjetG9qk3o+FQpwLjxnyEE+21aeyBbXe2Zxrz1z55HiSVypwRP6eYTc9/KxGdfnavGm4EoIQaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGsZWHPM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kerensun.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e380f7bcfbdso3955916276.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 15:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731715069; x=1732319869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nw3bU4V27TPmp6Re8ExQGjVU+DnBp9+SCSKcT6kc7do=;
        b=wGsZWHPM9DJFhYl7uYPChCdjLxC0U6w3Wjxr1b397gRk6h6PchEH+NmTkoBdEmLNb4
         WW9LyJ7rSqgqDnRXHQs7urQ+asNPGMWFwznVT3f7lx11Z9ksXnsNMAw9M8CCbWszfl8M
         UyEfqbZG7c4rYeMnF0bnIE5WrnxfHNAO+8gJEbO7KpZY/y/QWbfMA1QY13BvUajffJs4
         lNQvADMVHseOo2aRch6NX1HUVeWZkmJ0k2AwPzc1Rgl5UtEs8HWv4Cq1uQAK+yt2n6ic
         tWHzurJGC4GSctBpydVzWaGF/OpfoYvjIxXzHTK9HOvtEIv1mqeNmDqCNE1vDeTg6UNW
         u3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731715069; x=1732319869;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nw3bU4V27TPmp6Re8ExQGjVU+DnBp9+SCSKcT6kc7do=;
        b=mapLiP8Rm8cJuxVjwEU5ZF+5n+l1iZ4LkZXqnWl+UVhZrGPXgxedGumHv5DaqlU+ms
         fFcc1g6CA4MudQARwNXZDUdcBij2RJrX+dD7HLefAqcUUz1UnM8FTW4+Ji7dDD83rcs+
         VDnn8GSIjR1+tc4XFWTf2Ej+AstwA/LxFvwFotIzc5lIjFGe8omCvuYxkMyrfEAz07Ln
         q2c/rHLXxR+hPOBFmbcT7KYHEGUEaoOhm2bPFetYLR6REcNQ4PpM9fNDZu2Jn5e06Ctb
         ijhCJEkqz2h/OqVx6eYtGIJ2q5/hhJvpahl9c08vvjQU7FjrtKlRFDJGKtW4cVGELbaj
         i+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCU84d+i5rCkGmGgdA6pwolkr6wTdLMbAgJcVQYZJN1yYA+W2hqIQxqyOx55MtwyBGw97NxjHnZi@vger.kernel.org
X-Gm-Message-State: AOJu0YytpYAn37elpdOwTpE+aNQhfmW9xAY17Bgr1JU3bcA4RayIEX0B
	QWg+3ZX5PbvElGalcfIFZSdEFRugaU4LMJlvN47MQyw8UYQsY5WpF+iJHr1QgG1lkRGgrrujkTA
	ij0FOotolVg==
X-Google-Smtp-Source: AGHT+IEWq7t1tAIsrlf5M+Kv66u7NJ88IRp2HxreC5eRJF9TCkRDpi6vsM+EPFKgV8XHfVDcd5aH59gbHkuWqA==
X-Received: from kerensun.svl.corp.google.com ([2620:15c:2c5:11:f2d6:8e6c:5a90:ef1e])
 (user=kerensun job=sendgmr) by 2002:a25:6b42:0:b0:e38:7c92:33c9 with SMTP id
 3f1490d57ef6-e387c9235d9mr800276.2.1731715069167; Fri, 15 Nov 2024 15:57:49
 -0800 (PST)
Date: Fri, 15 Nov 2024 15:57:41 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241115235744.1419580-1-kerensun@google.com>
Subject: [PATCH 0/3] mm: fix format issues and param types
From: Keren Sun <kerensun@google.com>
To: akpm@linux-foundation.org
Cc: roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Keren Sun <kerensun@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix some minor issues including improving formats, update params types in
functions, and removing logic duplicacies, most of which are warned by
checkpatch scirpt.

Keren Sun (3):
  mm: prefer 'unsigned int' to bare use of 'unsigned'
  mm: remove unnecessary whitespace before a quoted newline
  mm: remove the non-useful else after a break in a if statement

 mm/memcontrol-v1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


