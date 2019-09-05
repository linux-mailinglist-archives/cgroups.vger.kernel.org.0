Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05C45AA96F
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390713AbfIEQzp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 12:55:45 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39423 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731492AbfIEQzp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 12:55:45 -0400
Received: by mail-qt1-f169.google.com with SMTP id n7so3615939qtb.6;
        Thu, 05 Sep 2019 09:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U86ZblmgaF4eBV4iyqRJf/CbV9WbHkWYMeJ0zFkqIu0=;
        b=TyUOTJJGoo8GODrCt/6YB1x/8aj4n9IE8jT/v+K7tCsOLINcESeyD/Ij4NXtMIB6Sy
         17L6qDvWQyCyeC7XEmXxoOnrWrvCkDJaDG0IEmRd9h3bbbHGAAp7YN0Z5zIHZIZQLjXo
         e7R4fvWV6g6XW9aD+hLJiCg7Lmv5aeBV8tuo+o7VsPjG3fXt7UmiwBwDqQNJlFXWk3TH
         5zwtfxF6mzHV0xMeRObFu3TfF099rR2GJ8US0yfbmsALUGRng05iBs5g6jzYHGRvKk8h
         FRvrTCHS5oUC5grWyibA9V7qghdaMk9oAmt6exGDzNOXAJpBRPdCLJ0cj/yBZJkPaFfd
         sbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U86ZblmgaF4eBV4iyqRJf/CbV9WbHkWYMeJ0zFkqIu0=;
        b=AaGh5aAxS1kkttwlWW1hzOrtLI04mgCTsJuuHe/KUgC6l7CNGVlFoGPKxQY3ibD06M
         SCSC8X+4RRoEDzGI6q36Stpv+YyyKV2Uip9jN10hOteMbSMN4P1pZNZGw7QFRgg59SwG
         lXnKMoDmohrsgXZpwrR8m/HevTmN134AU2EUOwZnmsQ7A991TtHQV6s57IA0qwAxsZPQ
         UxuQzbK1g0M4j4KkjffyPFv0n9I4Wx/q3SDwH9sEG/K9kxBtUS9eQhBwEK9SwlspDL12
         0qerDkdbz/MXVX3b/Sz5iRqqPsJSsN8d3e24K7YJKCr7n2AsR4efrlUbW4OlPTV0y/z+
         PzTA==
X-Gm-Message-State: APjAAAU9ptiZiNXOtCObdJWOrdGF8URMTjPe2nFnDjAm8y3UWh5M+8K2
        n0vHJVdEe9NZbdwsc7zVwbY=
X-Google-Smtp-Source: APXvYqxWVpg+iwFh32fbJZ2IVVdvSiiBQD6AcEmV0uXtGrMn3YPk/UP/cg4q73bDG/04BT3T30UTyg==
X-Received: by 2002:ac8:2914:: with SMTP id y20mr4722757qty.150.1567702543675;
        Thu, 05 Sep 2019 09:55:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:5196])
        by smtp.gmail.com with ESMTPSA id e7sm1083953qto.43.2019.09.05.09.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 09:55:42 -0700 (PDT)
Date:   Thu, 5 Sep 2019 09:55:40 -0700
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
Message-ID: <20190905165540.GJ2263813@devbig004.ftw2.facebook.com>
References: <20190614015620.1587672-1-tj@kernel.org>
 <20190614175642.GA657710@devbig004.ftw2.facebook.com>
 <5A63F937-F7B5-4D09-9DB4-C73D6F571D50@linaro.org>
 <B5E431F7-549D-4FC4-A098-D074DF9586A1@linaro.org>
 <20190820151903.GH2263813@devbig004.ftw2.facebook.com>
 <9EB760CE-0028-4766-AE9D-6E90028D8579@linaro.org>
 <20190831065358.GF2263813@devbig004.ftw2.facebook.com>
 <88C7DC68-680E-49BB-9699-509B9B0B12A0@linaro.org>
 <20190902155652.GH2263813@devbig004.ftw2.facebook.com>
 <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9F6BC6D-FEB3-40CA-A33C-F501AE4434F0@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Paolo.

So, I'm currently verifying iocost in the FB fleet.  Around three
thousand machines running v5.2 (+ some backports) with btrfs on a
handful of different models of consumer grade SSDs.  I haven't seen
complete loss of control as you're reporting.  Given that you're
reporting the same thing on io.latency, which is deployed on multiple
orders of magnitude more machines at this point, it's likely that
there's something common affecting your test setup.  Can you please
describe your test configuration and if you aren't already try testing
on btrfs?

Thanks.

-- 
tejun
