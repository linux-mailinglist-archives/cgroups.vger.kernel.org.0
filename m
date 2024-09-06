Return-Path: <cgroups+bounces-4726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B5596F062
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C7A1F27E93
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D71C9DF6;
	Fri,  6 Sep 2024 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="IFf5a5o/"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F741C9DF8
	for <cgroups@vger.kernel.org>; Fri,  6 Sep 2024 09:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616426; cv=none; b=Jf2wd3nyy89XYxIv+w/WJFY4m34eBDvu12V5wQxwXdlzp9h/KKMBXwrWWJ3QGk9Wkiip0HwAvDhNX3cxJMZFeKMtpKIIjnoJNe2WM4lj7J7OYY0uoWkfBf+wGPwneiB8tf2MaJvjvZl974RO9NfhsY2sfo5mZQQiC2aK4dioaxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616426; c=relaxed/simple;
	bh=IFiJzNa23HL4yv8NJuBXDog0rL9XAEykvFMCfcNcisU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WQmraIBBU6rCNbLglhLs1oMwZsqq4uCREC5Yve/Tfbar4yS+f6MKKous9VfMZRnSYPPUwVlj8N7Qk40MXIDF+pW1LlQrAd+C/EAgi+PfHPKyX1+E3nofCFosMpsMLLCHkHQjdKeFRBrvW/PWNaLxmVz+d5fWl2XnW0e6MohJhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=IFf5a5o/; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240906095333fb9c5a2a6b0ff6ddc9
        for <cgroups@vger.kernel.org>;
        Fri, 06 Sep 2024 11:53:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=6VoFJll+UytvMdR9ZwPf6T244iPbXuYc1jQw/YWFhao=;
 b=IFf5a5o//QwGazxn9uhFa7rMjQVkIGpi1g5YNZaci36YSaBTA2Mvw9YD43a2yHJIvqbYzC
 /M9yM07dsd7Q5zf3KyREHPSSCdNOU6ztSV0Zq9B1Io6q3TFwwrAlaP0jtFQIdIBH97GLMoFP
 EMYEagm1ed4Zpsplr6f4XArhcJV8PJbx+KhB5mmXsl13I0tzp5zOP/trXgeYAhHeBQECDy6K
 BK/V8xq5CyflLO4IGSVHpS1KIF5ygh7LEFStJmj4zoLt5FRa12VEBWJS8Yl3RgZT7XfQBcpQ
 GaB7x9qGj+8KDQmCghFMXWAQooGN2Hnzz0pmUEoS0CfDv4KCcNnNObxQ==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH][6.1][0/2] io_uring: Do not set PF_NO_SETAFFINITY on poller threads
Date: Fri,  6 Sep 2024 11:53:19 +0200
Message-Id: <20240906095321.388613-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

Setting the PF_NO_SETAFFINITY flag creates problems in combination with
cpuset operations (see commit messages for details). To mitigate this, fixes have
been written to remove the flag from the poller threads, which landed in v6.3. We
need them in v6.1 as well.

Best regards,
Felix Moessbauer
Siemens AG

Jens Axboe (1):
  io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers

Michal Koutný (1):
  io_uring/sqpoll: Do not set PF_NO_SETAFFINITY on sqpoll threads

 io_uring/io-wq.c  | 16 +++++++++++-----
 io_uring/sqpoll.c |  1 -
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
2.39.2


