Return-Path: <cgroups+bounces-1928-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4472F86D809
	for <lists+cgroups@lfdr.de>; Fri,  1 Mar 2024 00:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E03F6B21FF4
	for <lists+cgroups@lfdr.de>; Thu, 29 Feb 2024 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A36813E7C1;
	Thu, 29 Feb 2024 23:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ShtDbs5l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D756134427
	for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709250697; cv=none; b=S9Ys9BAftF8+Qz1JTSobX+M0c2Xd0KyppqveLSpX6j3u1n2kTi9WRSwgoCuqKPRF6A/2stw3XcWN5CvNIdKspFbJHsFWz8SZFdFUYHoizsp7Hn09HSVoWj/DcfN+/OiuV8HPtz82iZbL5pmmX7kktiN+Zr3dWD8iGf2rWPszy4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709250697; c=relaxed/simple;
	bh=wGdhmGNHVTXKtr8Coxlis0Li3Bk52TXuxtZPxJDknj4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hC37h5EiMkl48mFK/2KWNmNKxKy/pfgMogZNx4BKUaNV+g8TSoJwIw2Rjaun3SPTubgR61+IUIZqVFE+pevsTsN3RSnyvFHJhLGbutPmJPAAmWO7RUVDQKfal4xqmH4NJ+w9gKWgixrRgWfTemtOr6k0dq4PrpHy6BKMYLrsTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ShtDbs5l; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc0bcf9256so2258568276.3
        for <cgroups@vger.kernel.org>; Thu, 29 Feb 2024 15:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709250695; x=1709855495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGdhmGNHVTXKtr8Coxlis0Li3Bk52TXuxtZPxJDknj4=;
        b=ShtDbs5lOFNRkk6Jtu8JScDIID2cRH09UM0rEHa6BxrEoF+X1yaRbj3RU6CeG2XhPK
         zVUjNdXaoVzLz+bFIWeoKiSGRylGGXlRo6mJFlF7WJj9SahP4UalsFo0L/xewY5DgREa
         osgTNe6OR3RRQ1TfTrYpVaq/8NkfmHVW81dOlE6j13uUtz/wCMExtr6qZBSip0UPZMxK
         vBmnRFke3t1oLrdUr7NYDKmitiMwCeHgfNKwG14qmca5IiNjPuTgIS2r7LQdyFo65Aon
         XhYFKgsUxJxKU4s5tCcQSfbzWi1ZTdPIQZ+MzTIgld13X5wetBVgn41crBn0GwIbqdz4
         UKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709250695; x=1709855495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGdhmGNHVTXKtr8Coxlis0Li3Bk52TXuxtZPxJDknj4=;
        b=ba/0uVua3yA93rhHluK3G/UhfKviJll8KK5+wtATA7QgPGAX6II+7aJGKzwGeT/HM5
         iVVYEDMwhUGEZPw7yXpbtsYAZyuyPc9XysR335NJd1hSqjyah6cRQKmxPWGEBIBKtXaM
         kRfQVLCt9liBuGsglxtKfyFREKlLiHJA1R9HF/P0/ri5HjL+e0DoeRjIaR/UWnXjCv67
         dBQIkp2nr9GlFNpFRgvs+mPZ3J0jB4QmxmhIprB9CnWZ9PFBfU2hznKt5lZdwEuPzyzb
         Ss15fOlGKvilVb0SeO3L5+fyx94IUFT/IrGjZXta7deYOWwrZYUD0GUSto+/KyF6KKPR
         ADJg==
X-Gm-Message-State: AOJu0Ywa3hFm1wouseLvu6pIxUunXIR4NQ4+uEMySsdSmzmHscAgimqE
	wLDQBHEBtret4OraA5nmvwYAdDu1qso2M8BcLyLkTh0MPAK3qOkXXWLCVU/utUiVtddWxF+IivY
	MUV/5AEtHTU16cV/k4TZ5DLjr65XTzg==
X-Google-Smtp-Source: AGHT+IH867rn03DULgpAnZN98NdftWiJfM3usfRmVuNXYLi9bkM7Uz9nOwttJ34eI/OIA2Ca2LK6EGXn14L13DXQ6nxP
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:4ca4:66d0:de29:8d39])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:100a:b0:dbe:387d:a8ef with
 SMTP id w10-20020a056902100a00b00dbe387da8efmr177541ybt.1.1709250695530; Thu,
 29 Feb 2024 15:51:35 -0800 (PST)
Date: Thu, 29 Feb 2024 15:51:33 -0800
In-Reply-To: <ZcWOh9u3uqZjNFMa@chrisdown.name>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZcWOh9u3uqZjNFMa@chrisdown.name>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240229235134.2447718-1-axelrasmussen@google.com>
Subject: MGLRU premature memcg OOM on slow writes
From: Axel Rasmussen <axelrasmussen@google.com>
To: chris@chrisdown.name
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Chris,

A couple of dumb questions. In your test, do you have any of the following
configured / enabled?

/proc/sys/vm/laptop_mode
memory.low
memory.min

Besides that, it looks like the place non-MGLRU reclaim wakes up the
flushers is in shrink_inactive_list() (which calls wakeup_flusher_threads()).
Since MGLRU calls shrink_folio_list() directly (from evict_folios()), I agree it
looks like it simply will not do this.

Yosry pointed out [1], where MGLRU used to call this but stopped doing that. It
makes sense to me at least that doing writeback every time we age is too
aggressive, but doing it in evict_folios() makes some sense to me, basically to
copy the behavior the non-MGLRU path (shrink_inactive_list()) has.

I can send a patch which tries to implement this next week. In the meantime, Yu,
please let me know if what I've said here makes no sense for some reason. :)

[1]: https://lore.kernel.org/lkml/YzSiWq9UEER5LKup@google.com/

