Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01379A4440
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2019 13:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfHaLUQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 31 Aug 2019 07:20:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34201 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHaLUQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 31 Aug 2019 07:20:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id a13so10597425qtj.1;
        Sat, 31 Aug 2019 04:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LvmGRX4LOdsdUyhqS2DocPUCGusSGnHnPDwLS+tUYBw=;
        b=PK/UUpMIz6vGKESR/qWrB73mE5YrMA3srDYvsuYkZrvinUDXGVxGQ5MG3gdvcVS07j
         ZfANEcE/6el1beaQ4LSh3G1MTb05PufyP/OU6Q0VQOb2cDAcrIxDzvSZv+FYVzrntCvQ
         tTWEaEuJyTtf8N2g7gXdNHT7+q8SLvbxI/heNodCYdg+heOHOoAdjPP4Vsu3obkzZWSe
         H5W7JInfDelMo6SSnpOS6d0F9x0aIdjeq9YYKXaxhbj3w9W8nmYuGb4t7T/SW7pQKzB/
         097wawu8tSWVKZF9uRH0rbsWAQ5AUeikdovBIDTVghW4ccY/51t6WwfqP70a9c4bACZh
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LvmGRX4LOdsdUyhqS2DocPUCGusSGnHnPDwLS+tUYBw=;
        b=XqbXTdgCk0QLUjU09c18Ppvk5AVQOuGwEWyovFBFhLiSBv+AZP5Lb8vgvqRpOUPYsS
         I19cLFyA4qaSYnEWy+XeI/nhdcroYwEgg82J+4vo7lT1eY1iDlJpidarz+Ic3WYhsPun
         wtc5/82vpJjK/LTiX+E08PNY1U8Uu+2lOgy8baWMqJTolSW33HJOysjsLu2nzduVo5IH
         FfuIKtVyodwKhd0CxQ57EMb5eXWbKodUlRom782fpYpwaXJirlUcjEHL2ZeQlzxnKv4A
         dxI9JOdFMp7jhNTxvvDmNgnd4Qp9Jnv9Rvdmz0zTAhVZCU0oSROaZKqgxLCyO+1BZ6Aw
         0hYQ==
X-Gm-Message-State: APjAAAV8VuD4LHHuMkoeOCWHz8x2+BOXt5UJFCZrGbNXj+PPKWP5wIuX
        UnJsNMNjGDpVdZdn7dW8/4w=
X-Google-Smtp-Source: APXvYqxlmdRha80klC3NPhknthgVd3QVg1cGBUKDxmEcoq0Bjs+/s8SS3U82mQXt9So7bUSlMmHy0A==
X-Received: by 2002:ad4:4a92:: with SMTP id h18mr13034019qvx.235.1567250414665;
        Sat, 31 Aug 2019 04:20:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::3986])
        by smtp.gmail.com with ESMTPSA id t15sm1442361qti.12.2019.08.31.04.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 04:20:13 -0700 (PDT)
Date:   Sat, 31 Aug 2019 04:20:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, newella@fb.com, clm@fb.com,
        Josef Bacik <josef@toxicpanda.com>, dennisz@fb.com,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, kernel-team@fb.com,
        cgroups@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        bpf@vger.kernel.org
Subject: Re: [PATCHSET block/for-next] IO cost model based work-conserving
 porportional controller
Message-ID: <20190831112010.GG2263813@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <73CA9E04-DD93-47E4-B0FE-0A12EC991DEF@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73CA9E04-DD93-47E4-B0FE-0A12EC991DEF@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Sat, Aug 31, 2019 at 09:10:26AM +0200, Paolo Valente wrote:
> Hi Tejun,
> thank you very much for this extra information, I'll try the
> configuration you suggest.  In this respect, is this still the branch
> to use
> 
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/tj/cgroup/+/refs/heads/review-iocost-v2
> 
> also after the issue spotted two days ago [1]?

block/for-next is the branch which has all the updates.

  git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next

Thanks.

-- 
tejun
