Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC7CA2020
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfH2P44 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 11:56:56 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:38391 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfH2P44 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Aug 2019 11:56:56 -0400
Received: by mail-qk1-f181.google.com with SMTP id u190so3400367qkh.5;
        Thu, 29 Aug 2019 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebjcblE+kxdokmjeo9JfTde5NEZGUN+yLxUfBY00nF0=;
        b=D6977bRWi1U1MlPh/embKVUWFf1b3dSi7HwF68a6Mxi7L1SX4VR41iIkKqE9csKH21
         lSTOObC3A8BZMuxVngiF5uG4UyUVcCAB5sDGK7ymiIBLNoXs5c0d2Vlyp/Rpn+TbemRE
         xgNPEP34ZOt8Io4+LBH0ANDzoMVi0qykZJre8+VSiMd8R+c3HFAc0la2j7tnXrQq3Pdp
         diSk/fkxCKAl2xIPI1MUBFfEFZS9nKz0Noa95bmVacsOIDsgWfmdQ4MidxyALvP6HtUd
         mmb14y5r20iOBDzFHghRCvYy0T2+O5vDGGgeQw5lKkA/KpPZSCfJxWq/tPkxug6hR9iB
         K+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebjcblE+kxdokmjeo9JfTde5NEZGUN+yLxUfBY00nF0=;
        b=jnOUnVY37/3OCeRI6Iy3VVDO5Aa8Aih5SxXx1kTBqApTNYj9oZJAoEDa5mrb55ayD3
         bUv8Tuk2k3Pr5ZWhXfT+Z97UHrDk7ibMgS99UbpmGYUaO0NmdkVcvay8nCbCtx3YVEdu
         wmlGFzMgpJD3GS8WOsUIWXiEbzxVSc4OL5GL9X2XOEq2ZIGWztQh3EIRAlWMfcK6YSwT
         7cg/hMzkr5OeYrznW+/b96S1V3B5Vl8q50RNZwsJuEqxfC7Pc9ub8QQd9pYBsCkC5iJu
         BLp2dFgqT1ZdzRJG5n/IwVYYUyaNQZspvhP0/FY5MpDS+gLTvblL3mPNV5fDTbSgvkHd
         AopA==
X-Gm-Message-State: APjAAAXke4aQITcNGfYc+mRxZpl1Lq0B//XcI9Hl000aqp8wrkIOA45V
        qyeilj+DJ67KGkHmbFogLbQ=
X-Google-Smtp-Source: APXvYqwXmV4hUrqstIaOTbYKZJXxOp9tDSiRcx+99d4cEtCYCoB/CZjxOfbWhYwxNpuvf5hnjTawIw==
X-Received: by 2002:a37:494:: with SMTP id 142mr9783672qke.239.1567094215485;
        Thu, 29 Aug 2019 08:56:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:7e32])
        by smtp.gmail.com with ESMTPSA id q25sm1291885qkm.30.2019.08.29.08.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 08:56:54 -0700 (PDT)
Date:   Thu, 29 Aug 2019 08:56:53 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: Re: [PATCHSET v3 block/for-linus] IO cost model based
 work-conserving porportional controller
Message-ID: <20190829155653.GW2263813@devbig004.ftw2.facebook.com>
References: <20190828220600.2527417-1-tj@kernel.org>
 <50384CF8-39F1-461C-9EC0-7314671E5604@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50384CF8-39F1-461C-9EC0-7314671E5604@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 29, 2019 at 05:54:38PM +0200, Paolo Valente wrote:
> I see an important interface problem.  Userspace has been waiting for
> io.weight to become eventually the file name for setting the weight
> for the proportional-share policy [1,2].  If you use that name, how
> will we solve this?

So, my plan is just disabling iocost if bfq is selected as the io
scheduler.  It makes no sense to use them together anyway.  What do
you wanna do about the existing interface files prefixed with bfq?
Just rename them?

Thanks.

-- 
tejun
