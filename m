Return-Path: <cgroups+bounces-7799-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D73A9AF22
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 15:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378223BFFCC
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 13:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920CF1581E1;
	Thu, 24 Apr 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WpFPaRKz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3CF14F9EB
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501759; cv=none; b=FDC1JOK6z3Ovr5OYM2PRzXuPeCanbRUB+MsNoBzRknpGROyiglOpRdWGCu3TrHDH5irlo+ZIIYq1tuk74qW7OhLsMwZgtYkobxc+Vv2RrFnlWdohv6mtr2Fms2c5u/pSjwZT46v4YMJyPF7uXNYrRYig8VrFBvaZtyFxULOP41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501759; c=relaxed/simple;
	bh=WPtzaI6gzO+Ao9RQi1VweoMaU/O7Z60bQSJbDKqCmOY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uhem751kvFYPeZjwqomYDOizcqBOsKltf/AemEap6PAfoGIKz+23rT/78HMEGF1jVAbduZdE/cj1HJWIqh98bWGvCnEw4g2LkUJns9RzU8voCB90THQ/PE6iJNAMlBG9vvCOHQ3rIqksbC8tXGEEc7n0K6SLxYtnCuSSSi5+MK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WpFPaRKz; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so4125485ab.2
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745501756; x=1746106556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5y3kb7tbL35mrW374ozZ5zHoQ8x5ddd9COLH2ecrXT4=;
        b=WpFPaRKz0O7NIIA9IeGDNE5RIzQrP6u281XLpXkUtjG7MK31SOudfgRBWn6ciC/o74
         y/PPLkG6LYFqxeOnBxb55sXuZdg3W93rzV42d+CoRpFm2BpzVGzrfVJUdfnGbo26TXbG
         TRDcWNb/4PIOTTvTLx7lgY+qknDf8EPZq41YKaTUmJiiB9LZWwpmMQs9sEScLUMpQ5Zs
         ADN4+bouAJJ9Yt2lH524moLBwuMmZNs39/V84+QhlwtiGIlGNESImiz61sK5xu1Vyqhb
         3o38osX/jGESNj/opUoWouLXOqO3EEkwtb4wllC888SV38CTOfzVcP7B+QCtGlD+V6OJ
         Htww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501756; x=1746106556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5y3kb7tbL35mrW374ozZ5zHoQ8x5ddd9COLH2ecrXT4=;
        b=TztaJkdyWSAsGKbkuTjK94TPlN5OmuifI6mzEDQqsOLWz4uHQSUXf8H6feBJCbuCxO
         JmHTKyrWCqosHfOHSj+Nlea8a8+8B0HtaydGKxhXASsPFsv8JZeXI2zFbtwg2xKG7f7S
         syg7x3VSOsdtIf1+VnKkYlis7awPwzIaUJ2EBX2RsEB9vmVbcOPwp8XSnTPlW3W94+Bm
         s6MwS1w8WSQKG8SpuQ2O3PnPYykhh2sizKeg/gOCniEVyYt9v4xpw5NrnOzlw/TlfbFz
         SlISGllNbI+Nz8cb3+t1ghc83ky10tlhmau3qpTpOX/4cOrQz/zxrmOrjEU4qavYX7MC
         gclQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc3rkZGWzvbkbwLueqPujfL0/pB0Z5I63paqSDWZAzgC9uExThVjjXw6nfLvz+l3KYyU9wdjcy@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqaT+JdOzfJW5qMSnZvzO53imm3BVRzQZtHgEjvvPK2+wCQ8I
	6CIGRA0mJ+MoPUm05KrV3oCOoUZ7v0YrS/at5+uJg4C3cpmj1Rw+B2ya9FOCjSAcoQ+wAj38Xj9
	H
X-Gm-Gg: ASbGnctttHbt9tLRcW1WP+Ffux4LiPyl+hAhazmvy2lYtB1Ti+JHFEb2HBrYatVTufE
	AwMNg7YyfR5JJ1As8o+QCyx5kwam4x2eHong3HFNzvEU3WBmjOoh2/MJjndSI+yWs4+TpSbjXec
	P+1qdeNzKywm3cdZrHxkNuSfi+KtsPWrIXmLHuimMjLwBxK9DjMHv4wHe2JyqRnbokbQ9ZbLQJg
	jnD/ih2SWz7emtyZNcOpFozHJqOLVBzcVZG5tqvw2xk3fR7LflCyCJZTwydR93wHagtW/E7AMUq
	uU3FCP0k9f9nmqigHkB4hH9ogQMoqBk=
X-Google-Smtp-Source: AGHT+IHGUYup65Csh37WQAuNVZgmXMs0428N1C4YOSpFb5unVA+hY8Q9IKjnnn2p20qNo3hrxDTuOA==
X-Received: by 2002:a05:6e02:398e:b0:3d4:276:9a1b with SMTP id e9e14a558f8ab-3d93041e398mr26411495ab.16.1745501755935;
        Thu, 24 Apr 2025 06:35:55 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824b80d63sm286172173.94.2025.04.24.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:35:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
In-Reply-To: <20250423053810.1683309-1-hch@lst.de>
References: <20250423053810.1683309-1-hch@lst.de>
Subject: Re: don't autoload block drivers on stat (and cgroup
 configuration)
Message-Id: <174550175513.658353.8577093198336589021.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 07:35:55 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 07:37:38 +0200, Christoph Hellwig wrote:
> Christian pointed out that the addition of the block device lookup
> from stat can cause the legacy driver autoload to trigger from a plain
> stat, which is a bad idea.
> 
> This series fixes that and also stops autoloading from blk-cgroup
> configuration, which isn't quite as bad but still silly.
> 
> [...]

Applied, thanks!

[1/4] block: move blkdev_{get,put} _no_open prototypes out of blkdev.h
      commit: c63202140d4b411d27380805c4d68eb11407b7f2
[2/4] block: remove the backing_inode variable in bdev_statx
      commit: d13b7090b2510abaa83a25717466decca23e8226
[3/4] block: don't autoload drivers on stat
      commit: 5f33b5226c9d92359e58e91ad0bf0c1791da36a1
[4/4] block: don't autoload drivers on blk-cgroup configuration
      commit: c4d2519c6ad854dc2114e77d693b3cf1baf55330

Best regards,
-- 
Jens Axboe




