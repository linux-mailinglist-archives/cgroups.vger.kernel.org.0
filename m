Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209FF1A676A
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 16:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730207AbgDMOCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 10:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgDMOCK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 10:02:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2132FC0A3BDC;
        Mon, 13 Apr 2020 07:02:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b62so9460668qkf.6;
        Mon, 13 Apr 2020 07:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ITKk+IbM/Pu4iwCMAU82Dk9TCoQ6Vio94t7SmWjtKJY=;
        b=oohXv3GgKxF3JQKxq9eUkBNfeVoWdmwO7PciLXRyq4R+kxI5Zv/hFU86wvO2vaGEoY
         +ba/L/ysawNwxImhrJb5CEqTgej8lP9ibrtHhTLvVC+6zXe6LIt/4yoNNwDY8OpSRav8
         U0xVcD2Z/xP1RsSjMZl/LoerF2n1ace3iy+jfUvTqyF5EJuLsQaWLbU/nxo5SlHmp/oG
         XCSvoOd1kAzphvtwpgGZ4b/DIE6agvYmKEBDWiRYhrziszA+RKx/ypDrs/+0Lzx7EITX
         v+EYF1mOEHuHuUhWdGqzauOd9kR0Qvy6IIDglBUr0hAGP4sXyjbVkmdC1YH3N5FYuTtW
         8i8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ITKk+IbM/Pu4iwCMAU82Dk9TCoQ6Vio94t7SmWjtKJY=;
        b=W+nDd0ibtZIT61xrwyvGJdcWxqMtanrwREsdZP4lI8ynoiM2m91ZpevWuumB4mKL28
         ui8wGEv58j6mSsHcjQ3hPaH4SSdIRHO/WTH3Mot6MRbJb7WmQaw96+UqYlJAxNBBMZPy
         JGII0KCn4C73FASTrFB2cHOns17s/FcROYbPef0lt0TuPfpJmxpos+Zfuu5yM70q3RRc
         xKC9aAuvn4np7B+HdVludY04SGaVHumPRh8vJkVfsHwLb6MBGA6BEv6e/Nnnekx60Scl
         JRKNKzcvU6aXSnh9ZE/aXxxZbaegAOc/jeqveaWKJw9N3ofmnBwnbYvrz1OK2Avd0QaM
         2OvQ==
X-Gm-Message-State: AGi0Pubca1Yi89ZL+TWb+JQMqg5u4Lhpm2qn6U7qtpjRvrVFq4EeMP9D
        dmOmSJztPlBceDQxecicFsE86zt+QHY=
X-Google-Smtp-Source: APiQypLuTmPHWtZxfgG0mjY7lpX4MSh38cQgM2ohPQHg14AtAnHEB7qocja0Fw0LVK/xEgYdG8F8pQ==
X-Received: by 2002:a37:b03:: with SMTP id 3mr15773770qkl.67.1586786528891;
        Mon, 13 Apr 2020 07:02:08 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id l9sm8740713qth.60.2020.04.13.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:02:07 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:02:06 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@vger.kernel.org, cgroups@vger.kernel.org,
        newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200413140206.GC60335@mtj.duckdns.org>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <20200409014406.GA370295@localhost.localdomain>
 <20200409021119.GJ162390@mtj.duckdns.org>
 <20200409023857.GB370295@localhost.localdomain>
 <c2b362f5-36f6-116d-ddb5-2445d13d2bac@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2b362f5-36f6-116d-ddb5-2445d13d2bac@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Apr 09, 2020 at 08:08:59AM +0300, Pavel Begunkov wrote:
> struct request already has such field (see @stats_sectors) because of the same
> root-cause. I'd prefer killing it as well by following Ming's way, but otherwise
> it could be easily adopted.

Oh, I completely missed that field. Lemme just use that one instead. Please
disregard this patch. As for killing partial completions, while I'm not
necessarily against it, it isn't a no brainer either.

Thanks.

-- 
tejun
