Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEC113862
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 01:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLEAAU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Dec 2019 19:00:20 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52886 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLEAAU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Dec 2019 19:00:20 -0500
Received: by mail-wm1-f49.google.com with SMTP id p9so1656590wmc.2
        for <cgroups@vger.kernel.org>; Wed, 04 Dec 2019 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/cIVnfK0h4EAyO70Kj28ZHjID/6dmAPP1P3IXa3r8cY=;
        b=TVjYAmKrXvxJVUXqRLPi0FGjmA7EQ+MBWtY8BJFRURv7fAWuHEVwymXHXexGAzDSBG
         4vwGzqWWMDTBHDNOzLUB7DORoS8+0f5DEkqeHqTl6cudQkXPA3qKAaZU4HFDtVX3Fhji
         bFR+7kdeEi59dqe5pNGDT9vXtjjqNqFboXI57047XqlZrSj1+S3+uyyjVhMOYQ3AHF5x
         G9klB13sdrEjRv1HLRzUfYTT2sSTdgeY+0GxKkqo0GBgtGRmLnmmmlqL2YSbGkCWKgmx
         p9++ySV+m3zaz9vYhfo/+JtY6LYumFCuC/w549X1DKOLpEeeTuF+r+AXKsrNATut24a5
         hNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/cIVnfK0h4EAyO70Kj28ZHjID/6dmAPP1P3IXa3r8cY=;
        b=rtfwENq38O9Xjsidly8RMUmcX7ICO0bg87Rmb64RXpXdzK6TQXUtQHNs62dW9EYS2F
         BVjY8lQ7Qq9r95eHApX6zFo4AGLxhIr1u2Wz675q7IfMrCT1kNQVfZ7x7R1AbTdlaUAZ
         PUR4ZuMax8Ju/5vK4Pd3CBwDPFrvehSmwkBRl2Rie4FDB+GsYqaNLXdetleH6I/UNwI4
         e09sXGsQ/Tvf4irN5P5nTmZM4VyYOACP1QkjaYTiOvV7g6904nfWtjY6tvh3sI+Kj6uq
         vt4Q0uHq/T9MwlkchWsXX+pte3ENbwc32+XycyYAVUQ1lzt+4AtZgI6Ztfjdp14KiBxI
         t0lg==
X-Gm-Message-State: APjAAAUQRSHWqEd96kV2NpDGGhepHSYuX+Fp5ZZSrl7BdQoiwGKKzvKX
        DsF/tl/gZsMLAg57fLHpjiT3UPwdqh6Tt9EhDraXefVR
X-Google-Smtp-Source: APXvYqzK7cPMBvCAVtXCop9cNX4pCt4/7hrXYBeNa5rt7ihLjOCny4dngtuLsg2qVf4yTP30WmshuFp6TsaYZAuNWwY=
X-Received: by 2002:a1c:9602:: with SMTP id y2mr2077662wmd.23.1575504018667;
 Wed, 04 Dec 2019 16:00:18 -0800 (PST)
MIME-Version: 1.0
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 4 Dec 2019 19:00:07 -0500
Message-ID: <CAOWid-cR0ZqTja6rBjBcBLUwSFR2i3ZczTGOxpQFgvBSF0xLjQ@mail.gmail.com>
Subject: Question about device cgroup v2
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I have been reading cgroup v2 for device cgroup along with bpf cgroup
and have some questions.  For bpf cgroup, is it typical to not have a
default bpf program to define "normal" behaviour?  Is it fair to say
that, for device cgroup in v2, if it's not for the v1 implementation
as the catch-all, userspace applications like container runtimes will
have to supply their own bpf program in order to get the same
functionality in v1?

Regards,
Kenny
