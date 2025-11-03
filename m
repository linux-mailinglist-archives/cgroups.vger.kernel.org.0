Return-Path: <cgroups+bounces-11547-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9118BC2E5D9
	for <lists+cgroups@lfdr.de>; Tue, 04 Nov 2025 00:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8073A943B
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 23:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF7A2FD66D;
	Mon,  3 Nov 2025 23:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YM/vBNLf"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276D23184F
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 23:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762211089; cv=none; b=qDIfRZpYGBszigVNb6mtQC0JlZCvA7xnfVKAeK6uKZV71PZSVbmj3CWXT8I+DqfzRrcsh9+6cnfjlwdE+BlJhxqGg5e8TXK6tFne1loNB41xAUvA7G8KiNTrRFW8aPHhIeJgXool7UyiISrEaUAI8EQ+kHsIYEXtrdO1s/IxcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762211089; c=relaxed/simple;
	bh=qFJb3QTz/3jg/L6x2lbG2psgJfjIQh5q1KW1+nPPaBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa9wM56mq1ttSLtx14XBEjd2tQGiBxUWUKu/xvIv+rp9Jnzb5PQVKuq6pl1Eel1ypWcQBnCzYZnWu5ThcKAr43YVfipvPVa4wVj4uhSI0nBGMqVzsPW0qETPOcfHgfjwJTM9Z310VZrXPONfd1x2VKRpmOEqgpTFfe3IpKLuTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YM/vBNLf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so989167366b.0
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 15:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762211086; x=1762815886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=YM/vBNLfGZhALocJlfoM6aqdmbn5u8aYcjTXacwZOFqpL3l5z8OuzQs6K2rZ842TQq
         JDUFj37ukjeLXKuhviMAaY+wo1sBiAhilUnarZzwRPT0jgmXXWP8ZMmsSwdqGyzz6RnZ
         yxZ7p0axNYKHN/OuxGRYqE0I0tFcS69gd7FaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762211086; x=1762815886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZH0fDpUKrbZ7Y4RH7y1khfYrGo0F4yDKdY+imctMyp4=;
        b=siDzrP3EODzKQwtgadJwAYpBTbZEqd2H8ef7kD8I4qvbD06byg2mMX3jW7wL/kTtM/
         kJn8Var94L9N79fhAR6dYT66jXkEgpdAJwRMyrbDdUmMZ8L0vTnbqwV5VsSIPmJEAW7p
         X2kkSQ/5gW2aFGQhBgQWklFp7HY9Sb5VFiTgXH9B05FvsdQ1XgNCyAHHWe1s9u46BtVX
         bhV9Zy92n/mYFxy+bht6KyLfazB4QbQGt4cuROh/CNbtxBbjozptmK2yyBHCxU5Tj1xh
         mNMKSDvoNbZV/kDu3o9mfPx7+tzKdw3EGp10VXG+iH+xTNUI8FGwAh3p+v2tQSrufG0v
         jibg==
X-Forwarded-Encrypted: i=1; AJvYcCXiHwQi2+QSuGdwO4ag9xWsfiH7+j3FNcTe/JVp1DsL6bBJTcm+xaplRyGClwvO+hWBWfbtBK0y@vger.kernel.org
X-Gm-Message-State: AOJu0Yzam9+JY+XWQTjsZloxt1OG8f5ZovnZQZCd4QTru8w+xz716JH4
	TYvB2XKfTJkv1IoNmjeRDec8qEkRmbXHq/gXlR5nJ7tTGscHDMqSTvmOmqEsCbllNIfYcYEeSUE
	gHbJcSTwpZw==
X-Gm-Gg: ASbGnctDSxiEpgnfK0szxb+kzoRuCCasGOBqZU10NxxjzoHZdivntDC+NL2nM3keXcc
	lxMu0nuCXxlb7YQ74PF0PiWwL3c6bdLKKtoLdf8hPFHVtP65+OArdrcnQ57ErGRVwRX3qkgBZ9o
	/mnHohVuP8Psvc4GnhhUi0DDbzVNioCJPX6SUKs9hxGDekPxboLO6cN7Z5wgWn0Ruj0T4SjTljc
	yoC3cPSDu3XXhbIjKYonM0J+pO3oSiyat8HQrpTkZKVxmMbWgCy1UUtTGM31jJZZpedmQOhWbaB
	NbeREAgx/EvlWQXYdxzPAZVzO5JFwO+VMv5OD0WW9SCSN2yvOKfP0JG2L5Zx6xS1I7TVb0SVTMP
	rc5B4ryHSY+QgeidKixiljF748x8emTsv6NjJmN36JHKsl+OWImSacfuQOhWi/YQbrHPQHM1o3P
	/DL890pruYI5yvqLfZ9jQY6hrO0CyC6ZBuQBwmuo+D0OcRJ0DfDg==
X-Google-Smtp-Source: AGHT+IHXYH9sIAXGV4RqgR1WZQftHppNjbGOg3vCLwMsXjEWBeF8vPB3pf6aQUGrH/N/eqvOslEddg==
X-Received: by 2002:a17:907:3e11:b0:b64:8464:68cb with SMTP id a640c23a62f3a-b70700d1daamr1637636366b.10.1762211085668;
        Mon, 03 Nov 2025 15:04:45 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0f1besm32527166b.31.2025.11.03.15.04.44
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 15:04:44 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so989163566b.0
        for <cgroups@vger.kernel.org>; Mon, 03 Nov 2025 15:04:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWV7C7SFXXMG8F6SaeickX548H6xiQjKqzM59C5vxn836R/724uSL6JPw7AsblXGkFMIFtMOsi9@vger.kernel.org
X-Received: by 2002:a17:907:1c28:b0:b71:854:4e49 with SMTP id
 a640c23a62f3a-b710854688emr499540366b.56.1762211084280; Mon, 03 Nov 2025
 15:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org> <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Nov 2025 08:04:28 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
X-Gm-Features: AWmQ_bmQaBgs1Hs2Yx75LVx_L0plRwfdpBhmjm5wyWf-G7aoJOGX7gmwXWEf8f8
Message-ID: <CAHk-=wiSmez2LFEpM05VUX=_GKJC8Ag68TJDByVPO=x4QwjyuA@mail.gmail.com>
Subject: Re: [PATCH 14/16] act: use credential guards in acct_write_process()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	cgroups@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 20:27, Christian Brauner <brauner@kernel.org> wrote:
>
>         /* Perform file operations on behalf of whoever enabled accounting */
> -       cred = override_creds(file->f_cred);
> -
> +       with_creds(file->f_cred);

I'd almost prefer if we *only* did "scoped_with_creds()" and didn't
have this version at all.

Most of the cases want that anyway, and the couple of plain
"with_creds()" cases look like they would only be cleaned up by making
the cred scoping more explicit.

What do you think?

Anyway, I approve of the whole series, obviously, I just suspect we
could narrow down the new interface a bit more.

                Linus

