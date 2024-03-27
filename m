Return-Path: <cgroups+bounces-2181-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1211E88EB41
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 17:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4428E1C2E0AB
	for <lists+cgroups@lfdr.de>; Wed, 27 Mar 2024 16:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703DB131BD8;
	Wed, 27 Mar 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1ttpBI+7"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1338130E3E
	for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556959; cv=none; b=RSz9bxQ7HvP8Vys1aBhZkmOsGDmPcU5f+W7ftldU9sxaXK0HDneGTfMlAHgEVTXIu9PykN/GFje3+UgLIcip48k1Id4fPIUN1h3rbvS+DblLWYjm4cuNM14D7QqHNnOiKCh2tlrNzu8iVkPt51/wrctxtjXXQ9z85XKN2T0gaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556959; c=relaxed/simple;
	bh=mII8AsdGfE3GWsjGzSAaPSlthCFXTu6oTlUS3OqE7E4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RonLmRFiutcnEAu3N3yAFipDgk1Pc3Z4GDA6cXqwawM/ctBb4r0T84U89uxaFzEAhfdQ7iNX0U+ke9ikE73Y6/qEd3BTZfBqJF0oAD7ehiLQc7N7EgHkyfvXnG/at23pDozrJ1SaxqYMta0Xh+YuAxlZ0IpahhusALdQgLL+jh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1ttpBI+7; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e696233f44so13772b3a.0
        for <cgroups@vger.kernel.org>; Wed, 27 Mar 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711556957; x=1712161757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBy++hZ/Vyd+a0hUTwNOGiU/nVRI0XUoA6D6aRpBZ4Q=;
        b=1ttpBI+7rVIS5tmL5/7bjPoQQpQYyZ8d/L4WtNCvpbMl4+emJpi8Z+x9IZSXkRm+Hk
         Jrm/RaIJWYIe+oA2V5MWo0vR4uATYN6uQisCJFozym1tt6et7yhtNsMsnuKQjCKkbIU0
         kTW6MNCfPHzgLLW5i3ZnXCv6ob3wryuGqbJiXV7aAWBMj29Kx29RP1R9dr2e24XDCGxR
         k/ns/a/5/t0zhCc6dmRPeFfbCvIiyVLLPYo8PJBi2sQxn6YkJeCc8sWPIEmHADvQfHoh
         2a3XOjjnCVPdVT8CWbhNkUOU9tarNTddGNmh7sN7VU8f2NmaxjCqrgBOeheLYE3ixmd/
         fNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556957; x=1712161757;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBy++hZ/Vyd+a0hUTwNOGiU/nVRI0XUoA6D6aRpBZ4Q=;
        b=Z3ge3/EeQp08qRV9U93GgKguN2USVs5tcQtdW8Wy/Sb3ZGSvUDcbbP4O3TKCincAd0
         ddGNLtuIBRpEDbRDmZJHlr68mYxhkpSysQVjLyqpJizPIQJ1QnxUN4quXlJG6WO1DMDy
         xt/9Wje9Sjjj9pNy8l51RY3i+8WicuL6gf3nS/mD1HBwRnDLeGDd0E2yuAohtRoOTMAq
         F95pNGVvkZEeR7Z677ZCbh6owwP9pHTmMVUpkFfUJ9WoOqUZpo4gr8disM5PPfHSgzyi
         3/TPe2TZrAxF4lO6XX0Rna+XbWxamOBcPdVzYcFyaTvLnwVdwwQRa+mAdHSgJds7G9om
         dCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl/UVX7wwvVNwOsZkhw0oSBE38NT4UFKHYRYBNxIIJe5UIwenj1TbgOS0BnhUak0yQFOfYP8WT6i6ytQw4uTaXxcvJO1tikw==
X-Gm-Message-State: AOJu0YzMoFaXRZSrxEyKJUwjoROB4F3ieeiW/wJ/T7Etw+DiAbjqt230
	8FzY6PdFGeJJh4lsOYoXyZ+96V104iawjRSoQoK5fwM9rNQiIsT9SBrofkaRG2uhDAr7cuB9gDg
	l
X-Google-Smtp-Source: AGHT+IE+wXfhdDTkk/+vUItbUPXH0iivy7FtbqgNS8SoDMVkJFdAWKbiI/nTGqqNROD7CdJcTeqZpg==
X-Received: by 2002:a05:6a20:3ca1:b0:1a3:b0a8:fbe9 with SMTP id b33-20020a056a203ca100b001a3b0a8fbe9mr565562pzj.1.1711556957159;
        Wed, 27 Mar 2024 09:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:5ff4])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79829000000b006ea75a0e223sm7998068pfl.110.2024.03.27.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, shli@fb.com, hch@lst.de, 
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20240327094020.3505514-1-john.g.garry@oracle.com>
References: <20240327094020.3505514-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] blk-throttle: Only use seq_printf() in
 tg_prfill_limit()
Message-Id: <171155695535.507853.13796923043030036347.b4-ty@kernel.dk>
Date: Wed, 27 Mar 2024 10:29:15 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 27 Mar 2024 09:40:20 +0000, John Garry wrote:
> Currently tg_prfill_limit() uses a combination of snprintf() and strcpy()
> to generate the values parts of the limits string, before passing them as
> arguments to seq_printf().
> 
> Convert to use only a sequence of seq_printf() calls per argument, which is
> simpler.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Only use seq_printf() in tg_prfill_limit()
      commit: 8ab13608cdad15fba1a5f43b8ef7d535e2faa7f7

Best regards,
-- 
Jens Axboe




