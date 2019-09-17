Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C419B512B
	for <lists+cgroups@lfdr.de>; Tue, 17 Sep 2019 17:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfIQPOI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Sep 2019 11:14:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35660 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfIQPOI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Sep 2019 11:14:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so4413492qkf.2;
        Tue, 17 Sep 2019 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YTPM3JqiD8c0vKHOkagGiX6LKB1z1tzStM2tYGa572U=;
        b=ILfTRupiAjHPFgfKc0g3+FaggjSSMypDaOk8g9mybm68giM925Tcm5vCM330ksEGll
         /L/qoHi5Xi+DhYyESQ9n0HpgfFRhX7btKH+OQKAKrJMgI/ZX1yFO146+eMG6w66/K/xi
         6IcyOMeQnwBWCOS4bvthkeRQD4jXQ/l+7WsusUExp1oJVu1CeBzrjM/fahln4hLwH/xJ
         2D8qJTO/4262g6ZdoggzspuKqFV21o35ZmjhbetgFD3m2YdAvgXcyvsXeTYvB5acm9jx
         ZT6vs6dJFGUd8Mi+kmVF+mM3CjHo3K/cF5yDmdYjSudHGMpXsuYbGoHddZ8PYYaBLuFt
         MT2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YTPM3JqiD8c0vKHOkagGiX6LKB1z1tzStM2tYGa572U=;
        b=RPi/DlafyriicxWhRqdCfAtvSCawfL2oKuQ/LTu+X6bgmwzK6j+tVawJB1ltD+KBKo
         R2X9+nIRvGZ9mRFHDMjLUk2sinrxBSUzSXn2d1m7akTGWITqHOHG+BB/VSCrZok29upu
         Tur0SdMhXeoQT9jga2GSfOYU3+vROAU0yN+fe8joj7tPWzuFIfPV3QmosGD/MKh7ON78
         w5y+9J2bYIqzWvk0F6efRxkiNMjYwP87oNCuWz3MrLsn2wV+Yx7nWWKSZquM7OboAuLw
         7ut1sQkPfTT7cvwmmiMpFAk44jPYoix6mvf0uWMp3U55yfARWsxajo+zG7PV7B1P1l/8
         Skpw==
X-Gm-Message-State: APjAAAWNuMjTw87r0uDTfcNSc9XGov9q7Dtz5iI7iWvB2JLnIerwU38p
        6wS6hVi69pD/FBW8TaqIpa0=
X-Google-Smtp-Source: APXvYqyboyASZsc7TMRNQ6PiKKkZ2Pf0sK4v7XZx2g5JQaJfXnSSJDx8o3pJTQ+SOzJkaaPaHoTjWw==
X-Received: by 2002:a37:c17:: with SMTP id 23mr4178217qkm.159.1568733246654;
        Tue, 17 Sep 2019 08:14:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::8d29])
        by smtp.gmail.com with ESMTPSA id v12sm1721049qtb.5.2019.09.17.08.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Sep 2019 08:14:05 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:14:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
Message-ID: <20190917151404.GJ3084169@devbig004.ftw2.facebook.com>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
 <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
 <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
 <64329DDB-FFF4-4709-83B1-39D5E6BF6AB6@linaro.org>
 <91deff5b-4a0d-a7ef-8bb2-7e7e5dad767b@kernel.dk>
 <8766046C-485D-479E-A4D0-AD9EF2F8EF7C@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8766046C-485D-479E-A4D0-AD9EF2F8EF7C@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 16, 2019 at 06:45:03PM +0200, Paolo Valente wrote:
> Tested it too. Waiting for Tejun's patch to re-submit it with mine.

http://lkml.kernel.org/r/20190917151308.GH3084169@devbig004.ftw2.facebook.com

Thanks.

-- 
tejun
