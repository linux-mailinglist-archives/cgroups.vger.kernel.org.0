Return-Path: <cgroups+bounces-6179-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EB7A1323C
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 06:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD7E1887760
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 05:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521511428E7;
	Thu, 16 Jan 2025 05:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6kJqRBU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B786E137930
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 05:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737004475; cv=none; b=K9/HHWfIgWZlZK9t5hvirbj0AA1R1vLa9xDkVTmzQWN9GLVuVwTzNFqGd39DNeeKVaiOIFLxWGd3yFACHXRm883gRQSE5Pxe/YOrQYq/9AJA+3RRzPGa5qrq3jCkCIlzPe37S2zUpzkOyv3eiklB2oRiUKFjQdn0wDXzV8X89aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737004475; c=relaxed/simple;
	bh=dqwomF0jneZ2eesxHAOTg6ZBsKrRr8TE5jUcMPIkbLw=;
	h=Message-ID:Date:MIME-Version:To:From:Content-Type; b=EecGClPSv5jr8NGD4AktLZYVJvuEttEH+YtkeEKUPrCc42MELWUTKUOJ4IN6pnOupCbcGf8lWgeTiFFnHmyWHMKHYe0oefLuMmsByZ5D97DUQ5YmBsSn12vtBSNKMvc9czoW9Nwnk0hFxlN+EzBkvClYfl10EsUyTYCibPKipz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6kJqRBU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ef760a1001so1020644a91.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jan 2025 21:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737004473; x=1737609273; darn=vger.kernel.org;
        h=content-transfer-encoding:from:to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L4+at9eF5iaEXIA00TwrwPLo3Lg2lEcOJzhDhljXtgk=;
        b=m6kJqRBU7omN8g9gRnhrQ5BbUhQY6Slwfm8amJ0c4LgSlFVfF6+/ymPehW7HwqSzS8
         zB75jO7QeDfccX4tIV5NZmZgFrjVlJQihXeLu0GqVMbnALkzCrUC9HW07x0IwK8z4vB5
         RlBposge8mz4BjhvL+and3aaY/RPi9zw7K2T6i/V3XQqP8lmUlcNmPigiCHAQtt3BAmr
         Dq9dzg23LrJSvgyBbFLJFTGhM5xTFRNNL/NmruEeIkAt+ePX2vARbd7hpOV/U56kYTK/
         9cGW8e1MvKr+mgg+dgGkHINzxBEsU9az4JB5uUF8iyfbzPcvZBHBnDRwWrfflAAjvQ2L
         G/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737004473; x=1737609273;
        h=content-transfer-encoding:from:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L4+at9eF5iaEXIA00TwrwPLo3Lg2lEcOJzhDhljXtgk=;
        b=nse/oUepyyZfDXgrcPtlC1kaRu9ZY5To53NcR4S24oGWRQnadImzhqt3kqBmqVNjKc
         cNmHef6Q/Z9dktrKvc4Z4Kic3QQZF2rSXSSQHCrQ7pkVv8EOD/qyjpPrzgbUSKSVOnhX
         TBZcHr2jdIITIvnqL7tGAn1uX+NUBgp4JFRM3M0ggHnwn8hAq3jgjQWRCWpcG+dEjv+x
         +h73HfzmrRqtNLnYRQZzFlazha7G1t7W588iZcPb4hegpwcKAFoQmTdPEFxxsd68b4Cc
         RPLeu6H+kV/33dPW7L/WENE2g18Srsnpo3I5/8bLQmJdOKBVL0tfcs0N8SXTkZOknvAf
         hiSA==
X-Gm-Message-State: AOJu0Yw5yentmo/49uXYyPTalJDmAmBgmnFoFqy94c+0FdapCbdFDCEt
	pyGuL/6tBRqS/mr9OHd3axaSGB6fV6ZPPc4N+n5H+/E+AAB35ZcW+ZbCyw==
X-Gm-Gg: ASbGncvQggsnVTLcaOhsHJPJm0L6kDLqzy9I4hILSAhf/45b3E0bPTqH9NIPxgu11fp
	ke5GTg3bsnenZ1B1Ug0dMCesIqwOZjpjz2ju8gwcb183LnfYyzLuf/cqFuzgH5K8XQoDTquG6GW
	VpqweqreLpzI+jTnkpHE9OwWL+9AtbWQlBLX1k52BgE5M4cxRX+BTN/rqAhlx3heSFRvSl6fthG
	7xIdbXb0p2Wtac/mbW3zR7OSnLvcLc9MTtn7Epj/bAwl2Dqqloqp1U2R3AYAzm3HE6LRybsJFY=
X-Google-Smtp-Source: AGHT+IFzGUUaeMVND9nG5DWEd9+QPisa4gZR+ICZLuJmX+ctJhLZB12kegoGaWlNe+3Yiz3sCAyL8g==
X-Received: by 2002:a17:90b:4c88:b0:2ee:5958:828 with SMTP id 98e67ed59e1d1-2f548f2a01emr48318960a91.9.1737004472586;
        Wed, 15 Jan 2025 21:14:32 -0800 (PST)
Received: from [172.23.161.24] ([183.134.211.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c15bf82sm2308369a91.7.2025.01.15.21.14.31
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 21:14:32 -0800 (PST)
Message-ID: <c8068c7e-a0c6-43df-9070-2c8b1c987b7f@gmail.com>
Date: Thu, 16 Jan 2025 13:14:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cgroups@vger.kernel.org
From: Tao Chen <chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

sub
-- 
Best Regards
Dylane Chen


