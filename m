Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAD46268B
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2019 18:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfGHQmq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jul 2019 12:42:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43106 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfGHQmq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Jul 2019 12:42:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so15536758qto.10;
        Mon, 08 Jul 2019 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IxAaS8HkYeCdm6ofdJNfkVr0RYEAJ+U8cg6TKAE1aA=;
        b=L4VgEUxFKymN8SdwCiz5jn/rBEPjrGbx7eFnC/6wSUv7PRduz3U9K5Wb58pE9nCwOh
         K4B+yYRyrknRJhYhK5GxOAr8okc1478Hpn7cwz/VKt0SCzvrBwHR/NOc9+F67juzgoUl
         TlucAUvTpmHDN6YI/nfX0Cv+I3FnSvxeTZbthwIBDS/D5/643uM+t1caAPoJBE3QKINO
         hkjzqay4+jr7+ZiC4mBgaYshjyViUjma8mTmO9MpWs5vwFYwofGWzCwYgk9D7k/ajgk/
         0RpyJHJRof2GfzuXUrUDsf76MOC/CVeHbyq6lFHXgsRZhHhALQFMfMuY+g/Evqa19ZPf
         upmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IxAaS8HkYeCdm6ofdJNfkVr0RYEAJ+U8cg6TKAE1aA=;
        b=h7vsA4/009uCoTiU7rnU+ZgLpGRAwol2QCfpv4MkxyIOmD/8B9BstXrx6rrI2kGVBV
         vZ8SCH9soz8XVtx+jkBL0l+FepQQLCl711+gqzoA25pfX9/m9lbwu8voKs/ha40SubYJ
         BKd2ju/JO1D4mErMe7xyABgmx0Z9t/lwNwdO3BKra7z2mqsKfIALfS+90uev57NjXjko
         eViyQG+RjpJ8KHjQShDwIlrXwJCamqY/2GIIAP2+eH15CGb4ypTq4M2tN1EblDo2euDQ
         3EHI8UxJroBMANAw35RciqmBHKeQVHQBubMoWuKItCGjv9qgdA8bCtyGhK/+sLONr9UG
         IocQ==
X-Gm-Message-State: APjAAAWY0f0zvd0tdsVJ/yBIEeIbae/CQfVgc9gpJr6wYUgZqjZAw9nI
        pOW6CaujoWSfh9AlcHw1dvYhFaNlAwE=
X-Google-Smtp-Source: APXvYqwOFtpEKmE0vYok9cs+Q6wE0KUH3YBAjuKmXTpvOHBb8y0HkU2ai1QhoHte1/udNlbR+UNmJw==
X-Received: by 2002:a0c:95c6:: with SMTP id t6mr16273425qvt.134.1562604165035;
        Mon, 08 Jul 2019 09:42:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id y42sm10823867qtc.66.2019.07.08.09.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 09:42:44 -0700 (PDT)
Date:   Mon, 8 Jul 2019 09:42:43 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peng Wang <rocking@whu.edu.cn>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: minor tweak for logic to get cgroup css
Message-ID: <20190708164243.GE657710@devbig004.ftw2.facebook.com>
References: <20190703020749.22988-1-rocking@whu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703020749.22988-1-rocking@whu.edu.cn>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 03, 2019 at 10:07:49AM +0800, Peng Wang wrote:
> We could only handle the case that css exists
> and css_try_get_online() fails.

As css_tryget_online() can't handle NULL input, this is a bug fix.
Can you please clarify that in the description?

Thanks.

-- 
tejun
