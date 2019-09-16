Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 649E7B3D6A
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfIPPQs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 11:16:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41752 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfIPPQs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 11:16:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id x4so207349qtq.8;
        Mon, 16 Sep 2019 08:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=to+g4mrtJdYUkTxkKpAQLy9ttRtsAGqphpzLEO+R2Do=;
        b=k3p4HOtMQrmIbyPz6c5OGR6zKDjk6SwAb5skOSk/70p9X2AUBOqKiVnERofdCGPvuJ
         7XnTCfIUqMbB3GzGT1Rg65tIWDWtrk2EXIRNbvneDZr/lEf92aZYvOj8jDZ8p7wwBEeu
         GzW6Aq+SjNLt94jtH/6A5G+YbVYn5gVzdCIeQdm9ZPp0Aktgy6faZZ7MWjYa5u4Je8IA
         Fgo2vfXKBCI1Y3FEj3C0SqYrKonhjy7OOgrE3uURHf3LQvDoqInFGe4VAVJY6eLxscTQ
         wycQv3/vorliAMyMGOgfwBuTi06Mg7WIFkESkzCwCkAsT2VZ7Jb37HDenfbipCvrglYR
         /rQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=to+g4mrtJdYUkTxkKpAQLy9ttRtsAGqphpzLEO+R2Do=;
        b=fUvgImH5tbqqUfzwh3bz8Qq9D1xlJk7y2hobinGTq4lZo4C485KUeA3kkMTjX3bJV5
         nHdDW+JF5xaPwPwSJqel69KceCESgOBFhT5CksHlYDw+9Cf+mDEEHg7lrRdtnRjitFR6
         9rLAWdfSxvBEzCk0SmrBZ1T0MDKOw3QYXAYvOoYveBH1AxiHm5HjRwsxi842IrDgklE2
         FOknVRn0LB3EVOkxZ1SJk7KnIGXF3I6nQche9J46KBzjtmMYrVxbFOuPqiIOBFP1QVFc
         puTmvpEesgp0nTZw1yF1i12kfqC4lF/zZWnciP6GG69DHzzGXoH8B2mxyBq/0m9g+bsB
         UoYQ==
X-Gm-Message-State: APjAAAVfNzSzfy+cf0kwF1WUdtlTKF4Hjy8AR1fAlY7RWcNKLimGqpwW
        Hp+HfjcRgL9Zu6vpn5cYdOY=
X-Google-Smtp-Source: APXvYqyqPrBENt9TqR+iQcs6qeVCttvBTrm43rGMUcnP+AVAJyvGMbCrF6BJPKVAbcooUsjOUopjwA==
X-Received: by 2002:ac8:2497:: with SMTP id s23mr27632qts.329.1568647006769;
        Mon, 16 Sep 2019 08:16:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::c30c])
        by smtp.gmail.com with ESMTPSA id m19sm17940669qke.22.2019.09.16.08.16.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:16:45 -0700 (PDT)
Date:   Mon, 16 Sep 2019 08:16:43 -0700
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
Message-ID: <20190916151643.GC3084169@devbig004.ftw2.facebook.com>
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
 <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
 <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F3898DA-C61F-4FA7-B586-F0FA0CAF5069@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Paolo.

On Mon, Sep 16, 2019 at 05:07:29PM +0200, Paolo Valente wrote:
> Tejun, could you put your switch-off-io-cost code into a standalone
> patch, so that I can put it together with this one in a complete
> series?

It was more of a proof-of-concept / example, so the note in the email
that the code is free to be modified / used any way you see fit.  That
said, if you like it as it is, I can surely prep it as a standalone
patch.

Thanks.

-- 
tejun
