Return-Path: <cgroups+bounces-14235-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI/3KTI+nmkrUQQAu9opvQ
	(envelope-from <cgroups+bounces-14235-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 01:11:30 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AD18E53E
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 01:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5843063B64
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 00:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B17E17A303;
	Wed, 25 Feb 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIoNnpjP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF814369A
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978207; cv=none; b=osH88rW9tcSI+oMDXRtptc+8d/90oJ8r30Kek3JYDYJXQqQmyh9fZumuJ6/FLnMfRT0PJVaNWVCgmTwZHZBaL1I/hJfP413AlLNr2yC7SgMXl3KMUfL/QyUyJzBy65Fiauxp39V3m28G8ijY804a+TJmKgU5oLiiN66JPS3wEDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978207; c=relaxed/simple;
	bh=lnJzJYcUp8Sfs9nziKWZ5/7nLDmSiLwtdUfyUswMIhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JATadtBtBzcCEmRMudO6Fd5qSkxcjtfnJW8iPnsvM6NJ5jSmiUbCrrs+7y5G5msTWLYwjyO6W6zeXGMIPrVD4E4fGsw2zexXRZgTR6nJJg6OZgxcmiDFuXudqEQTQ24Aa0FxplY9YHt3faFsei7c71O3ipBAB0u6ua7nkwQjKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIoNnpjP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43988056dc3so997698f8f.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771978205; x=1772583005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTN9nDYyDw1VitSAoVU8XmQ2K7N+PmzLt6G2wl3/Yas=;
        b=GIoNnpjPnPFWsnbzF7ILSfRnDIToBUEKfqnkOYP2USSwwKEH65GHWOSMpXtnThXYVr
         Mgc5uxcOM7Wx4CMEUsEb5hklGQ9CJhl0GYnk/reHHJwRrOFoj5uqWqvQaR+zTV6UTc+W
         7gooy6rUM/QF2sHSsw9SZZraJUYmkka8VpeQ6MI1S28LMsZg6YPW4y3WvrMRjftznpRg
         6FjW92tDpUGaqrq3kT1M3iO2ERtw2LXw6OedHa+SxHF0KxaS7JVWzv4vrmn5ypn6OwUL
         NFTuWVr2sBOx9GKDRc7/4zHkZzZ2PskwCfcyYtyjkomSusWxPC6eyClqorxXrs4tYX78
         4Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978205; x=1772583005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTN9nDYyDw1VitSAoVU8XmQ2K7N+PmzLt6G2wl3/Yas=;
        b=r7GvCJpTmOXuectbV7S1P303v8Y7Fj8fsdMWlsQjbucDRCYatpvyyjctY1pbMk8pPW
         7fXrMZpU8GGvltzu+SMpO9W/VMDtfzLSjU29CL6WAQbxZcxYwJhNt6cRSEjmRaNBwbiY
         m70r59OIMTuMK7K2bXFm3zzm1UcCI/ezBvuKwN+rlMj+Nqm+PfyTw7LMfEynpHzioSsq
         oNfywrQcSfPUVi0dACIoxeTX9X6mLeBDoFW2wTh8Y++cL31wKgBSoehNsvTmfWa0HUzo
         4ugHWJla6UlUQVu59sN+sY64/Jgimv+QeOsLQzDuq4v+LSPzFAbfbOqJA8bjZnCZSn4r
         uY6Q==
X-Gm-Message-State: AOJu0YxFI+rOE6Rws5039NCypQFQJJXrvHJXiFhIz9oFMv0vuo7QqvrF
	JaGwVXARnjeMGE/oAoNtRAsZkGryRTzq3Cdu6QGzlSk8khojlTioVVlz
X-Gm-Gg: ATEYQzyVhIwmeFAQ2SaROtiLbHp8FOren+ExazplREJY26XYa6tes3JMwuGFVCzcncn
	xXOMfOnJ/J/lyMmn4NQS6SkwZvWF7xr4wgqOtk29gHHuufd7F5lDIf7waJ4Q9H+bxxBB68OEUn4
	fyPl3+/unSp1i+SgJhotZV7xznWZKp3eXzKQQuFvuNniFe4RjbAJ/0OOgY7ylrk0EzEpmnYVT+B
	ZOYjSsd51v/FTq2wYOiouT+lOMrRHHSgUMec37B/pTKqqRIR62ppGbtVeinDD+iyik3v+fdM2nT
	1XkiN/vRLC7kfPL59e0C9M7OBCupCbfiXbUmnzumh8KY4kP1ima3CgsaiJ/vOeTHDrMcdoWvJLi
	b4vgQwHwXLADWBd9ozhfuGIrJcCchdTcrJET7MsAJscKUlT2jvFs1bHnI0cUqqO8JlBhYmVMKl4
	zUzAEkQIFgvORpXQ4aC5Y=
X-Received: by 2002:a05:600c:37cc:b0:483:54cc:cd89 with SMTP id 5b1f17b1804b1-483a95bec82mr255382725e9.9.1771978204745;
        Tue, 24 Feb 2026 16:10:04 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483bd72bd66sm28594105e9.11.2026.02.24.16.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 16:10:04 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: cgroups@vger.kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Virtual Swap Space
Date: Wed, 25 Feb 2026 03:09:17 +0300
Message-ID: <20260225000952.2778156-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260208215839.87595-1-nphamcs@gmail.com>
References: <20260208215839.87595-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14235-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 479AD18E53E
X-Rspamd-Action: no action

Nhat Pham <nphamcs@gmail.com>:
> only tackles that same problem, but also achieve the dyamicization of

I think there is a typo in "dyamicization"

-- 
Askar Safin

