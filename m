Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13C6461B0
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfFNOwq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 14 Jun 2019 10:52:46 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728272AbfFNOwq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 14 Jun 2019 10:52:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id s24so1120866plr.8;
        Fri, 14 Jun 2019 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0HRENCM8//S+WGvQP1amFcQvEAKniYiMn7pbWKjyBdY=;
        b=TyVTGaOw5AtNg2y27QJA4f/taFVIo21wtfv0z2WUTclnFvohafgQjLOdGAtM5sZjXW
         adxtI18hJyHbxrjCmeTqI5/YcDHRTN18D/p+P3g7LxhBb9i/TZyjFv5ovj/yGzc9KUQA
         MbczNKRAp+ZOOgSP68Ob/KUtH/hvR53lN3fW4o5r3g0E2lgB3/KxZiKdQN+lhgVbdz5C
         UT+VL8iM+atG9nsnoEHBJwMm4lJ/iMsWfeLI/K00ZPAV5JToGPU8DtMi885Y5RptlX8k
         LSahdR7G3TjPGrSvg49LHEn6jf5N8lKBY2/FfkBq0ZysPLQoLvgJCeuCLpz9r+ImsZe9
         orgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HRENCM8//S+WGvQP1amFcQvEAKniYiMn7pbWKjyBdY=;
        b=YeR4xRiQW7zsFPzxKafQarps5nbTaITtNACzQ6Q4ym7IquI4uku8CGS11HfpMt7qPH
         EszQdQZ+Ebb2d0uzZh6Ok0PaIhrWnihzYbFfEOfIEWFl6CQ7TgbRBsmFIGPHhTQXMAH2
         AAYckEgKPYMwJavTRDTkC5bFDuT59VliL5YhaebgGgO73SluK+VJlYbEsQae72H27v88
         LdJIjZjeGEp8dnQmveUtRT9XlU//5U6UQIYHiLeEd137ajnOls6kFe8h3WSubyC6CLEn
         E/QrzijDeVsVpyOp/DS8x3/e0Ipe0RhTMZ7P1Ai/eaOfeCtrk9jOU/xkQ0u3M5eWualE
         jRZQ==
X-Gm-Message-State: APjAAAVOVK2RlgwVsemhMBWIGJO2nfj3lcEpZ0t891rKjfI4X2x/Lc2E
        WePWi8I8Ve1Pe4Ya/GOyLtw=
X-Google-Smtp-Source: APXvYqyFUmlEREi/X57+HY4aEPz63qUPvrk2aqLcRGoJiiT/qF11K4eFgDz2Y3M6c8EbIuSjXZEhcw==
X-Received: by 2002:a17:902:8f81:: with SMTP id z1mr27307623plo.290.1560523965030;
        Fri, 14 Jun 2019 07:52:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::1:b330])
        by smtp.gmail.com with ESMTPSA id v64sm3706012pfv.172.2019.06.14.07.52.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:52:44 -0700 (PDT)
Date:   Fri, 14 Jun 2019 07:52:39 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Quentin Monnet <quentin.monnet@netronome.com>
Cc:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH 10/10] blkcg: implement BPF_PROG_TYPE_IO_COST
Message-ID: <20190614145239.GA538958@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614015620.1587672-11-tj@kernel.org>
 <e4d1df7b-66bb-061a-8ecb-ff1e5be3ab1d@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4d1df7b-66bb-061a-8ecb-ff1e5be3ab1d@netronome.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Quentin.

On Fri, Jun 14, 2019 at 12:32:09PM +0100, Quentin Monnet wrote:
> Please make sure to update the documentation and bash
> completion when adding the new type to bpftool. You
> probably want something like the diff below.

Thank you so much.  Will incorporate them.  Just in case, while it's
noted in the head message, I lost the RFC marker while prepping this
patch.  It isn't yet clear whether we'd really need custom cost
functions and this patch is included more as a proof of concept.  If
it turns out that this is beneficial enough, the followings need to be
answered.

* Is block ioctl the right mechanism to attach these programs?

* Are there more parameters that need to be exposed to the programs?

* It'd be great to have efficient access to per-blockdev and
  per-blockdev-cgroup-pair storages available to these programs so
  that they can keep track of history.  What'd be the best of way of
  doing that considering the fact that these programs will be called
  per each IO and the overhead can add up quickly?

Thanks.

-- 
tejun
