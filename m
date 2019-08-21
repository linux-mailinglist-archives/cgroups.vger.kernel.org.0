Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC497FA0
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHUQEe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Aug 2019 12:04:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43769 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfHUQEe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Aug 2019 12:04:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id b11so3630990qtp.10;
        Wed, 21 Aug 2019 09:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pSYvDILhSH8fJWFn1Ay93bkSas+NlIGIDDL+tHz2nnY=;
        b=FcPaI0pBK/tsTJ85fkJV0GzNaa0VI6xq2/3C77dJ9Ksg2LPi+NeYin58kEZaHWQ4+c
         yNts5ywVYjfMNCER2xvTfME0oKqC0YC2I4+K1tsuNpQiaJjKZTyj3LDo3/o+40aLy1b3
         xFROy6h268Qz/2709NunEce2lWelxf9pFlX7BM8kPI3y5yOWd5UyF8HaxBcv8mpUorwb
         8wJ1/du7AiJGYKqbpfRUjO9rT+TCM/8hnViWhPuAotTO6NOkCjN1Clp8ecE6hIl6tYqF
         MHer6bExHhfCK5pjD900mPPO3BKg9ILIPrD3FA13M/iRdL1oZqc+Ge1OIPSGrhdITT6H
         MvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pSYvDILhSH8fJWFn1Ay93bkSas+NlIGIDDL+tHz2nnY=;
        b=MPxfueIILTWXOUzpA+Z0oV1cWWEcBMtN+G/Vs2jwKy89V0dG1gg+05X5HgrU6UkPw9
         w+na9w4JaEBfEp9rZ3fJZ7YJbSblKg59j+WC1nEetRvV5j73u2HbFsRH4b+y7/RsY3EI
         Tkts2Mn8dP5s3Wujb2S5TGbbR59x820Wtuw6d3E/UtAuIHrVIfZjvoDpzbfzxECN6bpi
         HbckURyFhBT5525tD8fT7cBHsvQ8kc7tB0XKmeT7vY63ek0qAma35Tt+XqzAHwsgl/vp
         EagHObKFIBFAf4UopwBtkoFRTmf+eeepFAciZ+VP5rwHFu0nxkR2eW68/qotVogXWO2d
         EzVQ==
X-Gm-Message-State: APjAAAWJEw5RBtXNw0i1drRcZTSGtdL1HPiF09aFzepx5WV6Oytkv4dw
        5sUhikAyYYl9L4gzjo7D93WIQfdE
X-Google-Smtp-Source: APXvYqxpFrzdsIp5vYz/r7TIVsm3AF8l2qHkWaxK1IbWJsfJxsILknQZQre8GqBdTdcjbqhL1sL5hQ==
X-Received: by 2002:a0c:edcb:: with SMTP id i11mr18388359qvr.206.1566403473118;
        Wed, 21 Aug 2019 09:04:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id v126sm10464175qkh.3.2019.08.21.09.04.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 09:04:32 -0700 (PDT)
Date:   Wed, 21 Aug 2019 09:04:30 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     axboe@kernel.dk, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 5/5] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190821160430.GL2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195930.GF2263813@devbig004.ftw2.facebook.com>
 <20190816160256.GI3041@quack2.suse.cz>
 <20190821160037.GK2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821160037.GK2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 21, 2019 at 09:00:37AM -0700, Tejun Heo wrote:
> > 2) When you invalidate frn entry here by writing 0 to 'at', it's likely to get
> > reused soon. Possibly while the writeback is still running. And then you
> > won't start any writeback for the new entry because of the
> > atomic_read(&frn->done.cnt) == 1 check. This seems like it could happen
> > pretty frequently?
> 
> Hmm... yeah, the clearing might not make sense.  I'll remove that.

Oh, the reuse logic checks whether done.cnt == 1 and only reuse if no
writeback is still in flight, so this one should be fine.

Thanks.

-- 
tejun
