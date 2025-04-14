Return-Path: <cgroups+bounces-7536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5931A88CFE
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 22:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C340317A9D1
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C811DEFDB;
	Mon, 14 Apr 2025 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KRKKA9KT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06B155C82
	for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662369; cv=none; b=qR4SeaJ5MhATqTw3y2hlbe4Iyv3H/R2nBD/3EowxiYTHF1zFriR6uExThlyZG5yBp6VhSPUA/QGrpQcXl15roPZYi2pcbKehHf3N+YIOCV1gaAwGlIXX7Ssd4earcSrQsylPb1eDmkmjTbMw3mv8fQhT45TyL57AdeP4/IoTadk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662369; c=relaxed/simple;
	bh=e8RuQjvX7EC8rJIFazxow+KpM5ax/UsWJUoMj3kPKTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8qj1pd+i0od5mdm8/38+8bicMpqjvt3uW99rFTkAPTJgqjvLixlO2VJV6/OnxwAouH4v4Lja8P9kDI0g2oydIarU3zrwPUonpipvM4Kbak8VKaH7QEw0YAD7sb5qgyIY5BMKye3oekztMBcYvrFALSL0zaHBOOILalgPy7CXlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KRKKA9KT; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e6e2a303569so3601182276.0
        for <cgroups@vger.kernel.org>; Mon, 14 Apr 2025 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744662366; x=1745267166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8RuQjvX7EC8rJIFazxow+KpM5ax/UsWJUoMj3kPKTI=;
        b=KRKKA9KTJLwDOv/j85iqeAteHbnRRThNrFG1v9dr9pIvRgMvzICKCPFyrZO2Y3oUbR
         tutVDXS0X/8k1V/4dWxHPiqLZFSVfQGhXEAZZPdhCBUkYHOVKkeK5iwBWHcAYPZXLikA
         CECW1DqWpq6jcDUMFF4GbmIZB+PxBz32qmragIPXFTGnZR3L2FlhKqTPwjIPAYBinGpo
         HaxzZKEF/kHKeMFxWhs+woabXNqxnUrmYd7pe7DE20q/ldq+337zRrgGacCLMNKRVk9a
         EnHhVWJeMir1zo60IwygqgZrRKwHeHf56sqyKN2fxMcM28nLHSQKQW22TnzpAHrH5PI9
         8PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744662366; x=1745267166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8RuQjvX7EC8rJIFazxow+KpM5ax/UsWJUoMj3kPKTI=;
        b=YJvJl1oro19V9Zk7LNfbXi5UMJu2SLk0qtwFQn8ly10GONjjex4kfw2vcSO4NtwBXd
         zhAahD+rgBgpPU8sXN9BB4VTUDpEVTUycBliKu+xqBJfk5tfwT0Fj+982k/PjgRS5lgh
         2AZN+jV3OZDqsYMsj0jpfMr0jZTc6sKIpEz2GL6OYccE+/VlwyQjua9E05Lo0yNcs4UH
         /hoa19qJUq9fEf05g4oyup54V70EsaihRdzEPa4KS6wmFoqSCtUEsCeoFgsHNexKJyOg
         bT1UQpDrmk6GapP+hILJMYA16vqJz2U9ypFxH9JtbvLy6+AsyZd4vyrQSapm9w/j2gKo
         jtGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXewXe7g7g79lW2ZbP5CsMegsCtX5cZ+oCMeAyu5rNp6xG20W/AuBrnnZaoU0MtCqPikcD7lavF@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmCdzhw3EQT4tyTM644214tmq6Ckb+laNNWDwc443YcwY7oXf
	Q/6H9siKo+Yh9Lp2aEWEkFmhNsg53Q6dvwJ+66j5gyjW23PB4FcRZ6ckQt/sHNedSVn5sy2f71l
	oJvUBUJtHmaxCYjBMYI/b9XuUfgI3nkK4qM+i
X-Gm-Gg: ASbGncuTTTcAneI2sHTbXrG43qblOkPiPOqG7oEPOiDr3dqKlJ1POBaAYFJSM9fMTTf
	tvI4vuEbO4QE6jA3J0+G6rHTXVYSt/jBZUn/OEr4q4+9HzDzdQxGkT40P6Jnx5Aze39oP8Kno/O
	He6Q3Ap2VM9/61m9J1Id08DeBer/VuZooA/QTLS2C0JCY0Xy/KJG5MWWNgQ4iLAg==
X-Google-Smtp-Source: AGHT+IHim7LKMVAssyTOnOfMgHoryUchjWHO0ARJ2hg5JmtdO8AhbqOEh3YOdPUF47H4HZYQwddbnu499M0vFJgq5eU=
X-Received: by 2002:a05:6902:4912:b0:e58:a25c:2787 with SMTP id
 3f1490d57ef6-e704df84608mr21722964276.38.1744662366434; Mon, 14 Apr 2025
 13:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414200929.3098202-1-jthoughton@google.com> <20250414200929.3098202-4-jthoughton@google.com>
In-Reply-To: <20250414200929.3098202-4-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 14 Apr 2025 13:25:30 -0700
X-Gm-Features: ATxdqUGwhQ01tB21e31AgRtLSVaaR6Jizfi-T6B2oRJ8KFk1W8QQrgJ2NgNsjhU
Message-ID: <CADrL8HWfF84VLmrVkzXTdwi-xxbUTPRUBDx1URZOsYv1DuB1-Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] cgroup: selftests: Move cgroup_util into its own library
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:09=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> KVM selftests will soon need to use some of the cgroup creation and
> deletion functionality from cgroup_util.
>
> Suggested-by: David Matlack <dmatlack@google.com>
> Signed-off-by: James Houghton <jthoughton@google.com>

Tejun had provided his Acked-by[1] and I somehow forgot to include it.
(I know I should just use b4 and redownload the series with
everything...) Sorry about that.

[1]: https://lore.kernel.org/kvm/Z-sQ76PG14ai9jC0@slm.duckdns.org/

