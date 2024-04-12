Return-Path: <cgroups+bounces-2451-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C08A356C
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 20:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2308E283F1A
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 18:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4A114EC7C;
	Fri, 12 Apr 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaV2NFxU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215B114D70E;
	Fri, 12 Apr 2024 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945468; cv=none; b=CokQYdeV7SdqSxsSmwq06YAJAk7dh98qCVt1aVUrOzlPBDLw1quLBRxfgDMpI34Lhe1emAiVNSXy07b/FpgySzMWkp6ZP6xnO3IN4tcFNxgyTO2knmaYuao+BMdHciMykuqSn6HAu3D0vZxT6SIvEuQ0Z6IuJTWHTpYvRoXNUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945468; c=relaxed/simple;
	bh=X8JAZ83PISoSih6UqWtdaIMVzQTC/9WJWILUPIQBXJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRHofX9591XTo6IkeCIZMgIq4ERbH3Y73NlPjlxncuP5el+1cmT8SAqctZIoDHk5Z5TMCYZNoOx0ZnuLFCeLC/cN8gDZ1SGjQhfVW0nmltlxVQH2BmlW34IMYBef/m5ay+grApzhgtz8Fdy3f1bgr6ZJQWFWI/G1tFftC+fwdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaV2NFxU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e4f341330fso11596515ad.0;
        Fri, 12 Apr 2024 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712945466; x=1713550266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0JthIKMm0QudgaXVbOYMQ9cuPyBbvwy6KmupLEHj/Ww=;
        b=eaV2NFxUKDJhfShgSZOAp/6DbfWsMe8hUifndzvfGFjkq3uEM8bo0NprsQVU5mD44Z
         gLQRlm0COP6TBPEXO9vgF7XDtyg4NAgmlCfBUKR5bodmO21b3NQy99aBeitRqB6SGJAe
         Yuf8vrIApbwuM0qWB1OAj9sxFVSOIykR9zVSeCIncia3dVkiJa8zJk7YiYnV79BCbU0w
         Tcge7+FWwLpFzS9iqrlH8U6FRj5FDlu/xLByivAoGp5ES4S0c1drHd4o1ctQLDwD6RkN
         iOWYvRSgt96NAtMlvwap7xHhCNZm9ahICbT372yIwddRZk2le51PsHl/fvUB/Ryz+ufi
         SJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712945466; x=1713550266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JthIKMm0QudgaXVbOYMQ9cuPyBbvwy6KmupLEHj/Ww=;
        b=VoSJ4bZrWzPfIJRs2ZJM0tqeF0iER6aYfBVuijomx1CFzDHaFskh/QOnpWS4ZU4rOi
         NKInuPoiRn8WDVSEkr2ci1Uc9anRvJLqeAsC0ntQBzYMBw9JuMEbJ8KLKXNTzBU5jYdW
         BQU5Y0wej0HezeHBvb6ReSmJKxsEpVnfxZ1PL7kiBtRlHveL0vpL1LhHznUlWSGZ3prE
         VQ5ujdFyDp41VbHfCGqyGPukz1jC5EUdGkeLJ6KdYm4Q3g0hi3D8wdT5IIJPhxm2S125
         AfVUSqlctOUBfJtsarVRvH7cOt1db614JHZvxQQ0B7btNigG/Pspm028TMpk4wePul47
         eq1A==
X-Forwarded-Encrypted: i=1; AJvYcCWmXPbYaPLI5iYWxIBbZhIf62Fv9JTI4zCwcfwUJD59iwl3U8ki9WorKPqao/nJNkHGvQsQJOjC7AICiVpKHxjE5yUz1iX85naEDgSqpiXVzWSCDBMQMNR/ZL0Az+FThQUFGw+l0mZ+ATSSjCdGyF9AbXNzKe8so6LMoxCraMp8MjDr
X-Gm-Message-State: AOJu0Ywja89K7vD8WvBWz/90PIJgJNdSLp47OrwErgeytolvYbG4WtD4
	bYlXueOydfP+OBI4eLhCeNXYwf1gOP7At5gRduL5NdjPLfVAguW4
X-Google-Smtp-Source: AGHT+IE0PSTDSZKKtsu0hbpf/Klp71X2ePxEwc6wEp4D3GSUygJCRHA20izUrDuTvbH4UoBXRzSJUQ==
X-Received: by 2002:a17:902:9a08:b0:1e5:870a:b2c0 with SMTP id v8-20020a1709029a0800b001e5870ab2c0mr3134934plp.14.1712945466289;
        Fri, 12 Apr 2024 11:11:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a5f4])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b001e0bcccc800sm1283613plk.35.2024.04.12.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 11:11:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Apr 2024 08:11:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, chenhuacai@kernel.org, josef@toxicpanda.com,
	jhs@mojatatu.com, svenjoac@gmx.de, raven@themaw.net,
	pctammela@mojatatu.com, yukuai3@huawei.com, qde@naccy.de,
	zhaotianrui@loongson.cn, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	cgroups@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC v2 6/6] blk-throtl: switch to use rq_qos
Message-ID: <Zhl5ONFlPg4vqjGj@slm.duckdns.org>
References: <20240406080059.2248314-1-yukuai1@huaweicloud.com>
 <20240406080059.2248314-7-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406080059.2248314-7-yukuai1@huaweicloud.com>

Hello,

On Sat, Apr 06, 2024 at 04:00:59PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> To avoid exposing blk-throttle internal implementation to general block
> layer.
...
> @@ -832,7 +832,7 @@ void submit_bio_noacct(struct bio *bio)
>  		goto not_supported;
>  	}
>  
> -	if (blk_throtl_bio(bio))
> +	if (rq_qos_throttle_bio(q, bio))
>  		return;
>  	submit_bio_noacct_nocheck(bio);
>  	return;

This is a half-way conversion, right? You're adding a dedicated hook to
rq_qos and none of the other hooks can be used by blk-throtl. Even the name,
rq_qos_throttle_bio(), becomes a misnomer. I'm not really sure this makes
things better or worse. It makes certain things a bit cleaner but other
things nastier. I don't know.

Thanks.

-- 
tejun

