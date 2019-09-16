Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3187FB3D0C
	for <lists+cgroups@lfdr.de>; Mon, 16 Sep 2019 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbfIPPBt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Sep 2019 11:01:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44242 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfIPPBs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Sep 2019 11:01:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id k1so17047884pls.11
        for <cgroups@vger.kernel.org>; Mon, 16 Sep 2019 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VJiHjQXkSvCrS+jTckU1P35l9SFt5+c8OTQowivUijA=;
        b=H+xaKl8Ys5y/fCTmn5Ye6W5ZY+/Lx1ksn/Eck5AgznrbtXbtpcriOL+pW3Ll2+Ky1W
         740uwrAhbHkuTR4CrLeNOI+1iLKn5s+M5iWWvvTj175A2VEbgZ7UeiUMVzRIS0WvCC+o
         FVI6IDTMOLQi9roahi0STUL+wM+DuiFxFjgU7rkGY/7DSv3sZBNEsPqze/JARp4WdPia
         ravMYckT7RqUrUsaAPOCiHunSC1na1oo34gpqo3CmrF1NDfV8BsOoi5cLFC7FQmf3mXH
         wVcvJgKROzfr1sZ3xvToVYR819AGTi5UgkAd/nMTAsU3Wx1kkTawBt0RAoHNoSwoH9zL
         VjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VJiHjQXkSvCrS+jTckU1P35l9SFt5+c8OTQowivUijA=;
        b=QOP/1tUsv3Tzl5pX7VK6OMcIWLJWxAlEDio7n64yamQtd8ThG9cOs740wFCpWLMLg+
         67j1NkxIybAMV1gi2Lv7p/W2i9aTUhODeqxfoHf0ZYp+jGy0yRJ0fKkNSP5jYWcP/pKh
         AdFsMlZns3O99Zk+tryW5T4d/Sqq5rXl/IGViCu01JK7q5fDYzu1P6vsVuAhuFrBbJrT
         JYePN1U7lF1PrEkkKVDdI/3dNe2J4IhhJe5zKB+0HF7Yrdm/uPDNJ4KLkOR0gMuh08Q7
         Jvxb3wuwXzx4TrVuwyByGvgOKVXzVWAG8BgHuyU2AzP/6ImTfkBbvgIXuHPFOMiA6avr
         kcJQ==
X-Gm-Message-State: APjAAAWfXpNDd9RBpk4JG3TNhyFhW8qkNKmwTemnEUQ6bBH17ZjPBrsx
        ndJuFfsOkoCpshZ83EJrpoQ+WD2/BWDjCQ==
X-Google-Smtp-Source: APXvYqwqOxx+LkfRUIEtl6/qo7Mwj89aqZdsYS8/kvRGjv5mudVZGrwxTFl+fLZCohJra2JTTBPG6w==
X-Received: by 2002:a17:902:d70b:: with SMTP id w11mr170765ply.313.1568646106203;
        Mon, 16 Sep 2019 08:01:46 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2? ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
        by smtp.gmail.com with ESMTPSA id c8sm9226193pfi.117.2019.09.16.08.01.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:01:45 -0700 (PDT)
Subject: Re: [PATCH 0/1] block, bfq: remove bfq prefix from cgroups filenames
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        noreply-spamdigest via bfq-iosched 
        <bfq-iosched@googlegroups.com>, oleksandr@natalenko.name,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
References: <20190909073117.20625-1-paolo.valente@linaro.org>
 <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c67c4d4b-ee56-85c1-5b94-7ae1704918b6@kernel.dk>
Date:   Mon, 16 Sep 2019 09:01:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <80C56C11-DA21-4036-9006-2F459ACE9A8C@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/16/19 8:56 AM, Paolo Valente wrote:
> News of this change?  Can we have it (or the solution with the
> symlinks if you prefer it) for 5.4?

Coordinate with Tejun and bundle the stuff we need into a series, we
can definitely put that in 5.4. I did send out the initial pull request
for block, but I've got a few things lined up for a secondary pull
later this week.

-- 
Jens Axboe

