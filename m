Return-Path: <cgroups+bounces-10395-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CA2B958E8
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 13:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B81B19C1E68
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B4919D8BC;
	Tue, 23 Sep 2025 11:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NVjGcreY"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F607321457
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 11:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625405; cv=none; b=h2Q6DrEeyQVrthHTWGG0s54AXBfV26mnyoMHNkxsjyBVZgKVCaZS54rS7aZmamIl9SYGXj6mxjTHCHEtMURD1FYsMXeJi6Wl6dYuKZTiacvvC4xYToWzGvSJyXrDeuoc0ClJMj/Mutgnf6DGKjhStzH+3271uqh/7TUxylUAAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625405; c=relaxed/simple;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvuOX4imZ8gc1m07218Ez0KO2a2dwyH1ayAzUpS0KPyRfDpU8WXp35Sg2ERnQr1XEjptEcEHkCdCgG+uL+aedrJ7db/N1S3vEiw7AzC2N1tyFr8r29WeMbso/9+4QwwfM0Y/E9A8ariR8KlEhtCMHR0ehO8h5VCN44nrzAkqCUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NVjGcreY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758625402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
	b=NVjGcreYgOGYPX4pC6UZqrZ08SzO3gFMM72ycJCI543uhdOce6AdiTS3+h3d8Nk6smHipN
	Y5+mFkvtgexC+mLDaaWI9jHoiSc0L4CFCJJCXAHfR1O5DwPL7EJrDuEBpm6WB1vKI88+6N
	2g0I4sJ8wZ8dQpvvMrQ003v9rM4HJyY=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-ZT7CyQZCOTKTMTxpnPYpEQ-1; Tue, 23 Sep 2025 07:03:21 -0400
X-MC-Unique: ZT7CyQZCOTKTMTxpnPYpEQ-1
X-Mimecast-MFC-AGG-ID: ZT7CyQZCOTKTMTxpnPYpEQ_1758625400
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-54a849ec483so4414174e0c.3
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 04:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625400; x=1759230200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Swe6rY9gynxIoiAb72Hw4MkrpYa4S9mjWoRmp9FxCiw=;
        b=t/3LH6MmOpNcQW5r95OYeUtRwos+rSO5JlB4aqroZXu2LE9jqD9yEb9TLdhw4ZTm6v
         hqw9AEM91htJ5hUFQsweuLsAa/2Mj7l0GZ54vn8nDyuk/zC9oSFN1L5x8pAVVng3JVqp
         gJRJD1pihS8pfxvJLQUUmLTvOJc99Z7Y4yxkMNjAzhIFBgq9a8afv9ZuQ2GqaunQQHlv
         4hObnBOfczyj6B4lKeZmugD7IiTYdJvIgAIV3r9RF2YR9PoeZ9/7e5EmYxTFAfdnIuoe
         Gq6edOUhX5fQCXCO1okdU8CE4IlqvXYIPt1FCvaF9G4W1JuE4NnpLvsZ3XLaKH1OdK0q
         owPw==
X-Forwarded-Encrypted: i=1; AJvYcCW+WOCN4YViHKzFy5ohrDYVQFbCmNLvzwzSvVItZlziDgfszam8zeH04sseRW+KQ7Icip8FEHD2@vger.kernel.org
X-Gm-Message-State: AOJu0YzVl/foirEfZflkH9OCRkP681xObY1oI8QwOKqo6kaUtIU4PKpQ
	6vMBeSsPkJeOTPob+SYnWVj6zCJeHrJwHAKRC8hp2yygYYLbx1aQyrPWbbf8aZGTrehJvPnK7l1
	dFUgr2sBRuNdorEzLPshJIKlKHxsgWAkRTINZmozGWE8NeKGKReRfxGmXxwSqjU5GnQaeFafR2B
	IPXebWmWzt0WNuCDhOyYKO/G0emehBKl0zvQ==
X-Gm-Gg: ASbGncsSppQWHMsOHmglN7fmGlHyNfgTSSKRvkB+sVL9SkX1RRdYynTqbRhMQ5afYdT
	p6tTBVWOF8BuLVfyWNetRwFM66DcigwuoU4opHgbzM/TM1vfzDqxZ+tzI8ybKfMgtoPq8aDZv0f
	3PGAhU97rZynC/QI44QXuKrw==
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id 71dfb90a1353d-54bcb1d349fmr691534e0c.9.1758625400393;
        Tue, 23 Sep 2025 04:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmWnjjnlbxkqsmt70oRkDaJTjcTb/VK4xGaXasfxB0vFXQD9TngLFTar/C7vX/7UorI+HUBvcEWxOQXxVzWKo=
X-Received: by 2002:a05:6122:251c:b0:54a:8ad7:59eb with SMTP id
 71dfb90a1353d-54bcb1d349fmr691530e0c.9.1758625400121; Tue, 23 Sep 2025
 04:03:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923075520.3746244-1-yukuai1@huaweicloud.com> <20250923075520.3746244-2-yukuai1@huaweicloud.com>
In-Reply-To: <20250923075520.3746244-2-yukuai1@huaweicloud.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Sep 2025 19:03:09 +0800
X-Gm-Features: AS18NWAY6oD65lXZ0U5a_gALUERAdhfENkXD2FWMa3u6Mrw0iQdazbmftghMxvU
Message-ID: <CAFj5m9KSEvP_gqN5_51q_iaUrOS70xC5r-odJYLOami4EKDVUg@mail.gmail.com>
Subject: Re: [PATCH for-6.18/block 1/2] blk-cgroup: allocate policy data with
 GFP_NOIO in blkcg_activate_policy()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: nilay@linux.ibm.com, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com, 
	yangerkun@huawei.com, johnny.chenyi@huawei.com, 
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 4:06=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Queue is freezed while activating policy, allocate memory with queue
> freezed has the risk of deadlock because memory reclaim can issue new
> IO.

blk_mq_freeze_queue() already covers it by calling memalloc_noio_save(),
so this patch looks not necessary.

Or do you have a lockdep warning?

Thanks,


