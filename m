Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03FD23BBC9
	for <lists+cgroups@lfdr.de>; Mon, 10 Jun 2019 20:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfFJSXF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jun 2019 14:23:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39357 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFJSXF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jun 2019 14:23:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id n2so6076537vso.6;
        Mon, 10 Jun 2019 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZFqoQ1NOYvg67NnTQGvHpFt++wU3sOt+xafTmUoMtA4=;
        b=CIrSvqbul3dKDqKmx+MXHnrt0zVRSlnMXD02VsGK1E13v46iS6NppURtuIxPH2XPu9
         IZvPszVw8H/KZqu8IEYoPvFsADsS7ZRarU6YHsQSkyIJ+qQdhxQegDMH/Kx6D1+/bd86
         fACkoLbL3BmDxXzAm74qMiXgr4ZaaXA5yVsrq8w9P2X1+C7M76WzjcjueUdelaVY9hbx
         JWoM5eCxO3p6S92vov3M5DHfVyLr7FOk8PImyvqc0Oa5PaBZHs/tuxSXKFvv5pZ/MnSE
         A+bTyvlYeQhSwoPvbj7Ei5f4Q8MC8FD8NZdqiL9e5/sZNpv3fxNxRdLF756TXLlCIc62
         6Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZFqoQ1NOYvg67NnTQGvHpFt++wU3sOt+xafTmUoMtA4=;
        b=Jbo6Ess+dTBpsmcxUPZYE0uu7V3FPhpdcaFimv0nuBj7UCCfo4ZiecyaGT7ws8nihT
         tDPPniSIUgEIAWrp1TkcnckCRoHH9hUfGrmxiGXgjRHvzY/HQv9sqnfxdSolBLtVj9Gi
         lbISH3n3SUE57Qba3Q63lXZLptGQn6XuZq2zFggNfB7lStO8dw5NcOdyJhE2jTEkf9vx
         pyDt3aSxqKL1raD6enR0wSojmte2STQVV8hS8SPBijeOKkViIYYCMYcB0VWVZ46ajhGI
         /ELCOv/OQi6fYQ5w/Z7yD30kyv/ONJyJRDq9UvUxxqLxmUAlonOngV5O5Q0A0kWboAu1
         TQbg==
X-Gm-Message-State: APjAAAUmMnGnLflMVP96T1GhgkGEmnvOBhuGLZJTRBruyU6EYnsBZqKs
        BxxOEjOpMBBhCFVjT2sqK5E=
X-Google-Smtp-Source: APXvYqywlkdgZlRfY+CbhjUyIlZnjwv+3qwp5cY7vf0dDb8vIXVWhQWDr/cFzhkOfYkHTrRGeIaCQg==
X-Received: by 2002:a67:6485:: with SMTP id y127mr9979943vsb.19.1560190984378;
        Mon, 10 Jun 2019 11:23:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id u73sm2352895vku.37.2019.06.10.11.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:23:03 -0700 (PDT)
Date:   Mon, 10 Jun 2019 11:23:02 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: blk-cgroup cleanups
Message-ID: <20190610182302.GD3341036@devbig004.ftw2.facebook.com>
References: <20190606102624.3847-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606102624.3847-1-hch@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jun 06, 2019 at 12:26:18PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> below are a couple of cleanups I came up with when trying to understand
> the blk-cgroup code.

For the whole patchset,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
