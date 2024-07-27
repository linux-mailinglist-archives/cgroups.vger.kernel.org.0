Return-Path: <cgroups+bounces-3926-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CFD93E02C
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 18:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4360B212DB
	for <lists+cgroups@lfdr.de>; Sat, 27 Jul 2024 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80EB18562A;
	Sat, 27 Jul 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xkiQX+7F"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6417E5579F
	for <cgroups@vger.kernel.org>; Sat, 27 Jul 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722098047; cv=none; b=cHg/frCmwHS6D82gF6TS+gqyH3M+mBmZlWtnZFkCqAC4o/sCNEuPadTa1DuU8joGArtDao8zu3l6tDAmkHgmdEgAlXm2W61IdAxPXhJQdMTObdtUH95FjyuzW9jENRu9jyWafRmUlF0TY/GS8dyFB6atsrVsHEz1Th57FjmeSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722098047; c=relaxed/simple;
	bh=tYDcFLi5DC53BcRnZ20ipJUQdFy4ozwidqFJQUZSMrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z2yenVeZDjQs24gVUIkb47jQqAAji9eYCpWP/EFiLrVTmWdNZDhktMqJWptXNmuIPqxBO8j5TbFDbqyPDuwcWN113M7VgOg4hQ24c19HuEd7m+hLqOiUSHKWe0xUeFa4J3HQQcnAsRuRMzN/TsrBbLD2/Asx/kP/FiZbWEuqPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xkiQX+7F; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2643667f0c8so277319fac.0
        for <cgroups@vger.kernel.org>; Sat, 27 Jul 2024 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722098044; x=1722702844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PQUXj/we6PnQROMy3jytsmFgfmtKin4VhNZzgFedts=;
        b=xkiQX+7Fw3QvRaXk6qj0spGvfhPJ2cu7bXxoNiWrF+KB95uqYPCKsPEeOOkI2LpyC2
         Tx2e92Ibgp8DfIm6kNKBPip0wijbysvfsqbwqrwF0z+ntwZSQPaqdC0DBTZrXIBSWEiX
         7XtkkqVK/tmhYryhZ3uyAP6g2j5154CKp2FYkRXrgCLF3hrUGdlthH3lfg1cYcBfvzJk
         FfTykZo8mWhz0WXUXdNjBdNz3C/KJFrjkvTB7Fw5YenB/frlQ8dGKL1ngIGjPyylPxen
         mpzszBwsZfiN5PDg6kcFHDCZbUpabrnko+U0O8ZfRc1SQoolHw245sGjvDRt5RBUpgew
         JdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722098044; x=1722702844;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PQUXj/we6PnQROMy3jytsmFgfmtKin4VhNZzgFedts=;
        b=OHLo4k6dRZhIZcg6rg/EV15i/rC67/zSmn2V8g3+9UqSnSGmGCnfUstWXM3I3ydHeO
         j+Yf6RMKfVyP4DD0idwXd38wROZhGx1IR4thKKp0EOelITa3g9u0zJLnmncO3E/2ooKH
         rIvw9U3ymakHZe5QRMUeX82YKsojx84pAcIhy11qEHlTMXOAERlq580F4oc6MVfi/Zau
         ELqGxlmPa+ey/Trbargm0bAakLq/jEeeAU1oh3yL3w28youIM+vvGogCSRQFRx/H9j8N
         uEgqn0MMxLUO7KLDYXdc8sdmPITNYOj4Gy7Vp7W3sU/eml4JOGQEdapz/Dp0PWdPZyDm
         5kvw==
X-Gm-Message-State: AOJu0YxUOpgWBNc2iSjgkGsViEd+T0aLxKQzAjptVOEQQ3hpGADKmzyu
	W6Tcjn36Ya/Q/MCLFYGBNVwtcQXb4Z4lweQ+W0GLN34T2dWrQtQDxo32TDYbQ9g=
X-Google-Smtp-Source: AGHT+IFsAHHIfDcXfkali36ULU16u+D1XOW7r7zhohNlD8LFT+yEuff4pV7agcskLMPCFAzo9/8Nhw==
X-Received: by 2002:a05:6871:710:b0:25f:4ab7:5324 with SMTP id 586e51a60fabf-264a3536c9cmr5858111fac.2.1722098044330;
        Sat, 27 Jul 2024 09:34:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead86ffabsm4503172b3a.143.2024.07.27.09.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 09:34:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, linux@treblig.org
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727155824.1000042-1-linux@treblig.org>
References: <20240727155824.1000042-1-linux@treblig.org>
Subject: Re: [PATCH] blk-throttle: remove more latency dead-code
Message-Id: <172209804317.3204.11809829429859213146.b4-ty@kernel.dk>
Date: Sat, 27 Jul 2024 10:34:03 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Sat, 27 Jul 2024 16:58:24 +0100, linux@treblig.org wrote:
> The struct 'latency_bucket' and the #define 'request_bucket_index'
> are unused since
> commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
> 
> and the 'LATENCY_BUCKET_SIZE' #define was only used by the
> 'request_bucket_index' define.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: remove more latency dead-code
      commit: 01aa8c869d0cdaf603f42dc1d2302b164c25353a

Best regards,
-- 
Jens Axboe




